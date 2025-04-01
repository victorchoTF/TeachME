//
//  LessonListScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation

@MainActor final class HomeScreenViewModel: ObservableObject {
    @Published var alertItem: AlertItem? = nil
    @Published var lessonListState: LessonListState = .empty
    
    private weak var router: HomeRouter?
    @Published var user: UserItem
    @Published var lessonFormViewModel: LessonFormViewModel?
    
    private let repository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userRepository: UserRepository
    
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    let isTeacher: Bool
    
    init(
        router: HomeRouter,
        user: UserItem,
        repository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userRepository: UserRepository,
        mapper: LessonMapper,
        userMapper: UserMapper,
        isTeacher: Bool
    ) {
        self.router = router
        self.user = user
        self.repository = repository
        self.lessonTypeRepository = lessonTypeRepository
        self.userRepository = userRepository
        self.mapper = mapper
        self.userMapper = userMapper
        
        self.isTeacher = isTeacher
    }
    
    func loadData() async {
        let lessons: [LessonItem]
        do {
            if user.role == .teacher {
                lessons = try await repository.getLessonsByTeacherId(user.id).filter {
                    $0.student == nil
                }
                .map {
                    mapper.modelToItem($0)
                }
            } else {
                lessons = try await repository.getOpenLessons().map {
                    mapper.modelToItem($0)
                }
            }
        } catch {
            alertItem = AlertItem(alertType: .lessonsLoading)
            lessonListState = .empty
            return
        }
        
        if lessons.isEmpty {
            lessonListState = .empty
        } else {
            lessonListState = .hasItems(lessons)
        }
    }
    
    func onLessonTap(lesson: LessonItem, theme: Theme) {
        guard let router = router else {
            return
        }
        
        router.push(
            .lesson(
                LessonPickScreenViewModel(
                    pickedLesson: lesson,
                    user: user,
                    router: router,
                    repository: repository,
                    userRepostirory: userRepository,
                    lessonTypeRepository: lessonTypeRepository,
                    mapper: mapper,
                    userMapper: userMapper
                ),
                theme
            )
        )
    }
    
    func onDelete() -> ((IndexSet) -> ())? {
        guard isTeacher else {
            return nil
        }
        
        return teacherOnDelete
    }
    
    func teacherOnDelete(at offsets: IndexSet) {
        guard case .hasItems(var lessons) = lessonListState else{
            return
        }
        
        offsets.map { lessons[$0] }.forEach { lesson in
            deleteLesson(lessonId: lesson.id)
        }
        
        lessons.remove(atOffsets: offsets)
        
        lessonListState = .hasItems(lessons)
    }
    
    var noLessonsText: String {
        if isTeacher {
            return "You have no lessons!\nCreate some?"
        } else {
            return "No available lesson for you!\nTry again later."
        }
    }
    
    func onAddButtonTap() {
        self.lessonFormViewModel = LessonFormViewModel(
            teacher: UserLessonBodyItem(
                id: user.id,
                name: user.name,
                profilePicture: user.profilePicture
            ),
            formType: FormType.add,
            repository: lessonTypeRepository,
            dateFormatter: DateFormatter(),
            lessonFormType: .add { [weak self] lesson in
                guard let self = self else {
                    return
                }
                
                Task {
                    try await self.setLesson(lesson: lesson)
                }
            }
        ) {
            [weak self] in
            self?.lessonFormViewModel = nil
        }
    }
}

private extension HomeScreenViewModel {
    func setLesson(lesson: LessonItemBody) async throws {
        guard let lessonItem = try await addLesson(lesson: lesson) else {
            lessonFormViewModel = nil
            return
        }
        
        guard case .hasItems(var lessons) = lessonListState else{
            lessonFormViewModel = nil
            return
        }
        
        lessons.removeAll(where: { $0 == lessonItem })
        lessons.insert(
            lessonItem,
            at: 0
        )
        
        lessonListState = .hasItems(lessons)
        
        lessonFormViewModel = nil
    }
    
    func addLesson(lesson: LessonItemBody) async throws -> LessonItem? {
        guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
            $0.name == lesson.lessonType
        }) else {
            return nil
        }
        
        let userLessonBody = userMapper.itemToBodyLessonModel(user)
        
        let lessonModel = try self.mapper.itemToBodyModel(
            lesson,
            lessonTypeModel: lessonTypeModel,
            teacherItem: userLessonBody
        )
        
        let lessonItem = try await self.mapper.modelToItem(
            self.repository.create(lessonModel)
        )
        
        return lessonItem
    }
    
    func deleteLesson(lessonId: UUID) {
        Task {
            try await repository.delete(lessonId)
        }
    }
}
