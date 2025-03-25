//
//  LessonListScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation

final class LessonListScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem] = []
    
    private weak var router: HomeRouter?
    @Published var user: UserItem
    @Published var lessonFormViewModel: LessonFormViewModel?
    
    private let repository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userRepository: UserRepository
    
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    init(
        router: HomeRouter,
        user: UserItem,
        repository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userRepository: UserRepository,
        mapper: LessonMapper,
        userMapper: UserMapper
    ) {
        self.router = router
        self.user = user
        self.repository = repository
        self.lessonTypeRepository = lessonTypeRepository
        self.userRepository = userRepository
        self.mapper = mapper
        self.userMapper = userMapper
    }
    
    // TODO: Show alert on catch
    func loadData() async {
        do {
            if user.role == .Teacher {
                lessons = try await repository.getLessonsByTeacherId(user.id).map {
                    mapper.modelToItem($0)
                }
            } else {
                lessons = try await repository.getOpenLessons().map {
                    mapper.modelToItem($0)
                }
            }
        } catch {
            lessons = []
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
    
    var shouldShowAddLessonButton: Bool {
        user.role == .Teacher
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
            onCancel: {
                [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            guard let self = self else {
                return
            }
            
            Task {
                try await self.setLesson(lesson: lesson)
            }
        }
    }
}

private extension LessonListScreenViewModel {
    func setLesson(lesson: LessonItem) async throws {
        guard let lessonItem = try await self.addLesson(lesson: lesson) else {
            self.lessonFormViewModel = nil
            return
        }
        
        self.lessons.removeAll(where: { $0 == lessonItem })
        self.lessons.insert(
            lessonItem,
            at: 0
        )
        self.lessonFormViewModel = nil
    }
    
    func addLesson(lesson: LessonItem) async throws -> LessonItem? {
        guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
            $0.name == lesson.lessonType
        }) else {
            return nil
        }
        
        // TODO: userItem is in the router, so the fetch is not needed
        let userModel = try await self.userRepository.getById(user.id)
        
        let userLessonBody = self.userMapper.modelToLessonBodyModel(userModel)
        
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
}
