//
//  LessonScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

final class LessonScreenViewModel: ObservableObject {
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
            if user.role == .Teacher {
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
            lessonListState = .empty
            return
        }
        
        lessonListState = .hasItems(lessons)
    }
    
    var lessons: [LessonItem] {
        switch lessonListState {
        case .empty: []
        case .hasItems(let lessons): lessons
        }
    }
    
    // TODO: Implement DeepLink logic
    func onLessonTap() {
        print("LessonTapped")
    }
    
    func onDelete(at offsets: IndexSet) {
        var lessons = lessons
        
        offsets.map { lessons[$0] }.forEach { lesson in
            if isTeacher {
                deleteLesson(lessonId: lesson.id)
            } else {
                cancelLesson(lesson: lesson)
            }
        }
        
        lessons.remove(atOffsets: offsets)
        
        lessonListState = .hasItems(lessons)
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
            try await repository.delete(lessonId)
        }
    }
    
    // TODO: Implement better error handling
    func cancelLesson(lesson: LessonItem) {
        Task {
            guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
                $0.name == lesson.lessonType
            }) else {
                return
            }
            
            // TODO: userItem is in the router, so the fetch is not needed
            let userModel = try await self.userRepository.getById(lesson.teacher.id)
            
            let userLessonBody = self.userMapper.modelToLessonBodyModel(userModel)
            
            try await repository.cancelLesson(
                mapper.itemToBodyModel(
                    lesson,
                    lessonTypeModel: lessonTypeModel,
                    teacherItem: userLessonBody
                ),
                id: lesson.id
            )
        }
    }
}
