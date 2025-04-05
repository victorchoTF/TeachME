//
//  LessonScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

@MainActor final class LessonScreenViewModel: ObservableObject {
    enum LessonScreenViewModelError: Error {
        case noStudent
        case noUserDetails
        case noReceiverPhoneNumber
    }
    
    @Published var alertItem: AlertItem? = nil
    @Published var lessonListState: LessonListState = .empty
    @Published var recipient: UserItem? = nil
    @Published var user: UserItem
    
    private weak var router: LessonRouter?
    
    private let repository: LessonRepository
    private let userRepository: UserRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    private let isTeacher: Bool
    let lessonCardType: LessonCardType
    
    private let urlOpener: URLOpener
    
    init(
        router: LessonRouter? = nil,
        user: UserItem,
        repository: LessonRepository,
        userRepository: UserRepository,
        lessonTypeRepository: LessonTypeRepository,
        mapper: LessonMapper,
        userMapper: UserMapper,
        isTeacher: Bool,
        lessonCardType: LessonCardType,
        urlOpener: URLOpener
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
        
        self.urlOpener = urlOpener
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
    
    func onLessonTap(lesson: LessonItem) {
        Task {
            let recipient = try await getRecipient(lesson: lesson)
            
            guard !recipient.phoneNumber.isEmpty else {
                self.recipient = recipient
                alertItem = AlertItem(
                    alertType: .phone(getUserNameForAlert(lesson: lesson)),
                    primaryAction: .defaultConfirmation(sendMailAlertAction),
                    secondaryAction: .defaultCancelation()
                )
                
                return
            }
            
            urlOpener.openMessage(for: recipient.phoneNumber)
        }
    }
    
    func onDelete(_ lesson: LessonItem) {
        guard case .hasItems(var lessons) = lessonListState else{
            return
        }
        
        if isTeacher {
            deleteLesson(lessonId: lesson.id)
        } else {
            cancelLesson(lesson: lesson)
        }
        
        if alertItem == nil {
            lessons.removeAll { $0.id == lesson.id }
        }
        
        if lessons.isEmpty {
            lessonListState = .empty
        } else {
            lessonListState = .hasItems(lessons)
        }
    }
    
    var noLessonsText: String {
        if isTeacher {
            return "You have no taken lessons!\nTry again later."
        } else {
            return "You have not taken a lesson yet!\nSave one now!"
        }
    }
    
    var deleteButtonText: String {
        if isTeacher {
            return "Delete"
        }
        
        return "Remove"
    }
    
    var deleteButtonIcon: String {
        if isTeacher {
            return "trash"
        }
        
        return "xmark.circle"
    }
}

private extension LessonScreenViewModel {
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
    
    func cancelLesson(lesson: LessonItem) {
        Task {
            guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
                $0.name == lesson.lessonType
            }) else {
                alertItem = AlertItem(alertType: .action(deleteButtonText.lowercased()))
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
    
    func getUserNameForAlert(lesson: LessonItem) -> String {
        switch lessonCardType {
        case .student: lesson.student?.name ?? "This student"
        case .teacher: lesson.teacher.name
        }
    }
    
    func sendMailAlertAction() {
        if let recipient = recipient {
            urlOpener.openMail(for: recipient.email)
        }
    }
    
    func getRecipient(lesson: LessonItem) async throws -> UserItem{
        switch lessonCardType {
        case .student: try await getStudent(student: lesson.student)
        case .teacher: try await getTeacher(teacher: lesson.teacher)
        }
    }
    
    func getStudent(student: UserLessonBodyItem?) async throws -> UserItem {
        guard let studentId = student?.id else {
            throw LessonScreenViewModelError.noStudent
        }
        
        return try await userMapper.modelToItem(userRepository.getById(studentId))
    }
    
    func getTeacher(teacher: UserLessonBodyItem) async throws -> UserItem {
        return try await userMapper.modelToItem(userRepository.getById(teacher.id))
    }
}
