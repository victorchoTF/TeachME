//
//  LessonScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

@MainActor final class LessonScreenViewModel: ObservableObject {
    @Published var alertItem: AlertItem? = nil
    @Published var lessonListState: LessonListState = .empty
    @Published var user: UserItem
    
    private weak var router: LessonRouter?
    
    private let repository: LessonRepository
    private let userRepository: UserRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    private let isTeacher: Bool
    let lessonCardType: LessonCardType
    
    init(
        router: LessonRouter? = nil,
        user: UserItem,
        repository: LessonRepository,
        userRepository: UserRepository,
        lessonTypeRepository: LessonTypeRepository,
        mapper: LessonMapper,
        userMapper: UserMapper,
        isTeacher: Bool,
        lessonCardType: LessonCardType
    ) {
        self.router = router
        self.user = user
        self.repository = repository
        self.userRepository = userRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.mapper = mapper
        self.userMapper = userMapper
        
        self.isTeacher = isTeacher
        self.lessonCardType = lessonCardType
    }
    
    func loadData() async {
        let lessons: [LessonItem]
        do {
            if user.role == .teacher {
                lessons = try await repository.getLessonsByTeacherId(user.id).filter {
                    $0.student != nil
                }
                .map {
                    mapper.modelToItem($0)
                }
            } else {
                lessons = try await repository.getLessonsByStudentId(user.id).map {
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
    
    // TODO: Implement DeepLink logic
    func onLessonTap() {
        print("LessonTapped")
    }
    
    func onDelete(at offsets: IndexSet) {
        guard case .hasItems(var lessons) = lessonListState else{
            return
        }
        
        offsets.map { lessons[$0] }.forEach { lesson in
            if isTeacher {
                deleteLesson(lessonId: lesson.id)
            } else {
                cancelLesson(lesson: lesson)
            }
        }
        
        if alertItem == nil {
            lessons.remove(atOffsets: offsets)
        }
    }
    
    var noLessonsText: String {
        if isTeacher {
            return "You have no taken lessons!\nTry again later."
        } else {
            return "You have not taken a lesson yet!\nSave one now!"
        }
    }
}

private extension LessonScreenViewModel {
    func deleteLesson(lessonId: UUID) {
        Task {
            do {
                try await repository.delete(lessonId)
            } catch {
                alertItem = AlertItem(alertType: .action(isTeacher ? "delete" : "remove"))
            }
        }
    }
    
    func cancelLesson(lesson: LessonItem) {
        Task {
            guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
                $0.name == lesson.lessonType
            }) else {
                alertItem = AlertItem(alertType: .action(isTeacher ? "delete" : "remove"))
                return
            }
            
            let userLessonBody = self.userMapper.itemToBodyLessonModel(user)
            
            try await repository.cancelLesson(
                mapper.itemToBodyModel(
                    mapper.itemToItemBody(lesson),
                    lessonTypeModel: lessonTypeModel,
                    teacherItem: userLessonBody
                ),
                id: lesson.id
            )
        }
    }
}
