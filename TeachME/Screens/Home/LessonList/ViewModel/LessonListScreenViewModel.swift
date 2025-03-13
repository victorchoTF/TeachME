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
    
    @Published var userItem: UserItem?
    
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
        do {
            lessons = try await repository.getAll().map { mapper.modelToItem($0) }
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
                    router: router
                ),
                theme
            )
        )
    }
    
    var shouldShowAddLessonButton: Bool {
        router?.user.role == .Teacher
    }
    
    func onAddButtonTap() {
        guard let userItem = userItem else {
            return
        }
        
        self.lessonFormViewModel = LessonFormViewModel(
            lesson: emptyLessonItem(userItem: userItem),
            formType: FormType.add,
            dateFormatter: DateFormatter(),
            onCancel: { [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            guard let self = self, let router = self.router else {
                self?.lessonFormViewModel = nil
                return
            }
            
            let lessonTypeModel = try await self.lessonTypeRepository.getAll().filter {
                $0.name == lesson.lessonType
            }[0]
            
            guard let userRoleId = UUID(uuidString: router.user.role.rawValue) else {
                self.lessonFormViewModel = nil
                return
            }
            
            let userModel = try await self.userRepository.getUsersByRoleId(userRoleId).filter {
                $0.id == router.user.id
            }[0]
            
            let userLessonBody = self.userMapper.modelToLessonBodyModel(userModel)
            
            let lessonModel = try self.mapper.itemToModel(
                lesson,
                lessonTypeModel: lessonTypeModel,
                teacherItem: userLessonBody
            )
                    
            let lessonItem = try await self.mapper.modelToItem(
                self.repository.create(lessonModel)
            )
            
            self.lessons.removeAll(where: { $0 == lessonItem })
            self.lessons.insert(
                lessonItem,
                at: 0
            )
            self.lessonFormViewModel = nil
        }
    }
}

private extension LessonListScreenViewModel {
    func emptyLessonItem(userItem: UserItem) -> LessonItem {
        LessonItem(
            id: UUID(),
            lessonType: "Maths",
            subtitle: "",
            startDate: "",
            endDate: "",
            teacherProfilePicture: userItem.profilePicture,
            teacherName: userItem.name
        )
    }
}
