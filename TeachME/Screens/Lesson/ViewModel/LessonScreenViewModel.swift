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
    
    func onLessonTap(lesson: LessonItem) {
        Task {
            let recipient = try await getRecipient(lesson: lesson)
            do {
                try openIMessage(phoneNumber: recipient.phoneNumber)
            } catch {
                alertItem = AlertItem(alertType: .phone(getUserNameForAlert(lesson: lesson)))
                self.recipient = recipient
            }
        }
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
    
    var sendMailAlertText: String {
        "Ok"
    }
    
    func sendMailAlertAction() {
        if let recipient = recipient {
            openMail(email: recipient.email)
        }
    }
    
    var cancelMailAlertText: String {
        "Cancel"
    }
    
    func cancelAlertAction() {
        alertItem = nil
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
    
    func getUserNameForAlert(lesson: LessonItem) -> String {
        switch lessonCardType {
        case .student: lesson.student?.name ?? "This student"
        case .teacher: lesson.teacher.name
        }
    }
    
    func openIMessage(phoneNumber: String?) throws {
        guard let phoneNumber = phoneNumber, !phoneNumber.isEmpty else {
            throw LessonScreenViewModelError.noReceiverPhoneNumber
        }
        
        let urlString = "sms://\(phoneNumber)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openMail(email: String) {
        let urlString = "mailto:\(email)"
            
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
