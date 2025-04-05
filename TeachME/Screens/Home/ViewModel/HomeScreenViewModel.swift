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
                lessons = try await repository.getOpenLessons().filter {
                    shouldShowLessonToStudent($0.startDate)
                }
                .map {
                    mapper.modelToItem($0)
                }
            }
        } catch _ as HTTPClientNSError {
            return
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
            alertItem = AlertItem(alertType: .lessonLoading)
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
    
    func onDelete() -> ((LessonItem) -> ())? {
        guard isTeacher else {
            return nil
        }
        
        return teacherOnDelete
    }
    
    func teacherOnDelete(lesson: LessonItem) {
        guard case .hasItems(var lessons) = lessonListState else {
            alertItem = AlertItem(alertType: .lessonsLoading)
            return
        }
        
        deleteLesson(lessonId: lesson.id)
        
        lessons.removeAll { $0.id == lesson.id }
        
        if lessons.isEmpty {
            lessonListState = .empty
        } else {
            lessonListState = .hasItems(lessons)
        }
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

                try await self.setLesson(lesson: lesson)
            }
        ) {
            [weak self] in
            self?.lessonFormViewModel = nil
        }
    }
    
    var deleteButtonText: String {
        "Delete"
    }
    
    var deleteButtonIcon: String {
        "trash"
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
            do {
                try await repository.delete(lessonId)
            } catch {
                if case UserExperienceError.invalidDatesError = error {
                    alertItem = AlertItem(alertType: .invalidLessonDeletion)
                } else {
                    alertItem = AlertItem(alertType: .action(deleteButtonText.lowercased()))
                }
            }
        }
    }
    
    func shouldShowLessonToStudent(_ startDate: Date) -> Bool {
        let now = Date()
        let minimumLeadTime: TimeInterval = 90 * 60
        
        return startDate.timeIntervalSince(now) >= minimumLeadTime
    }
}
