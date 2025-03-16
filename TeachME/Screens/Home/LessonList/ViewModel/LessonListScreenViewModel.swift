//
//  LessonListScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation
import SwiftUI // TODO: Remove after DataLoading is implemented

@MainActor final class LessonListScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem] = []
    
    private weak var router: HomeRouter?
    @Published var lessonFormViewModel: LessonFormViewModel?
    
    private let repository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userRepository: UserRepository
    
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    init(
        router: HomeRouter,
        repository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userRepository: UserRepository,
        mapper: LessonMapper,
        userMapper: UserMapper
    ) {
        self.router = router
        self.repository = repository
        self.lessonTypeRepository = lessonTypeRepository
        self.userRepository = userRepository
        self.mapper = mapper
        self.userMapper = userMapper
    }

    func loadData() async {
        guard let user = router?.user else {
            lessons = []
            return
        }
        
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
        router?.user.role == .Teacher
    }
    
    func onAddButtonTap() {
        guard let router = router else {
            return
        }
        
        self.lessonFormViewModel = LessonFormViewModel(
            lesson: emptyLessonItem(userItem: router.user),
            formType: FormType.add,
            repository: lessonTypeRepository,
            dateFormatter: DateFormatter(),
            onCancel: { [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            Task {
                guard let lessonItem = try await self?.addLesson(lesson: lesson) else {
                    self?.lessonFormViewModel = nil
                    return
                }
                
                self?.lessons.removeAll(where: { $0 == lessonItem })
                self?.lessons.insert(
                    lessonItem,
                    at: 0
                )
                self?.lessonFormViewModel = nil
            }
        }
    }
    
    func addLesson(lesson: LessonItem) async throws -> LessonItem? {
        guard let router = self.router else {
            return nil
        }

        let lessonTypeModel = try await self.lessonTypeRepository.getAll().filter {
            $0.name == lesson.lessonType
        }[0]
        
        let userModel = try await self.userRepository.getById(router.user.id)
        
        let userLessonBody = self.userMapper.modelToLessonBodyModel(userModel)
        
        let lessonModel = try self.mapper.itemToCreateBodyModel(
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

private extension LessonListScreenViewModel {
    func emptyLessonItem(userItem: UserItem) -> LessonItem {
        LessonItem(
            id: UUID(),
            lessonType: "Other",
            subtitle: "",
            startDate: "",
            endDate: "",
            teacherId: userItem.id,
            teacherProfilePicture: userItem.profilePicture,
            teacherName: userItem.name
        )
    }
}
