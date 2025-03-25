//
//  LessonScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

final class LessonScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem] = []
    @Published var showLoadingAlert: Bool = false
    @Published var showDeletingAlert: Bool = false
    @Published var user: UserItem
    
    private weak var router: LessonRouter?
    
    private let repository: LessonRepository
    private let userRepository: UserRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    init(
        router: LessonRouter? = nil,
        user: UserItem,
        repository: LessonRepository,
        userRepository: UserRepository,
        lessonTypeRepository: LessonTypeRepository,
        mapper: LessonMapper,
        userMapper: UserMapper
    ) {
        self.router = router
        self.user = user
        self.repository = repository
        self.userRepository = userRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.mapper = mapper
        self.userMapper = userMapper
    }
    
    func loadData() async {
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
            showLoadingAlert = true
        }
    }
    
    var lessonListState: LessonListState {
        lessons.isEmpty ? .empty : .hasItems
    }
    
    // TODO: Implement DeepLink logic
    func onLessonTap() {
        print("LessonTapped")
    }
    
    func onDelete(at offsets: IndexSet) {
        offsets.map { lessons[$0] }.forEach { lesson in
            if isTeacher {
                deleteLesson(lessonId: lesson.id)
            } else {
                cancelLesson(lesson: lesson)
            }
        }
        if !showDeletingAlert {
            lessons.remove(atOffsets: offsets)
        }
    }
    
    var lessonCardType: LessonCardType {
        isTeacher ? .student : .teacher
    }
    
    var isTeacher: Bool {
        user.role == .teacher
    }
    
    var noLessonsText: String {
        if isTeacher {
            return "You have no taken lessons!\nTry again later."
        } else {
            return "You have not taken a lesson yet!\nSave one now!"
        }
    }
    
    var loadingAlertMessage: String {
        "Couldn't load lessons!\nPlease try again."
    }
    
    var deletingAlertMessage: String {
        "Couldn't \(isTeacher ? "delete" : "remove") this lesson from your list"
    }
}

private extension LessonScreenViewModel {
    func deleteLesson(lessonId: UUID) {
        Task {
            do {
                try await repository.delete(lessonId)
            } catch {
                showDeletingAlert = true
            }
        }
    }
    
    func cancelLesson(lesson: LessonItem) {
        Task {
            guard let user = router?.user else {
                showDeletingAlert = true
                return
            }
            
            guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
                $0.name == lesson.lessonType
            }) else {
                showDeletingAlert = true
                return
            }
            
            let userLessonBody = self.userMapper.itemToBodyLessonModel(user)
            
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
