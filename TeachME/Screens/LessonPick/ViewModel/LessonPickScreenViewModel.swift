//
//  LessonPickScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import Foundation
import SwiftUI // TODO: Remove after DataLoading is implemented

final class LessonPickScreenViewModel: ObservableObject {
    @Published var pickedLesson: LessonItem
    @Published var teacher: UserItem?
    @Published var lessonFormViewModel: LessonFormViewModel?
    @Published var otherLessons: [LessonItem] = []
    
    private weak var router: HomeRouter?
    
    init(pickedLesson: LessonItem, router: HomeRouter) {
        self.pickedLesson = pickedLesson
        self.router = router
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
    
    // TODO: Should load real data in future
    func loadData() {
        teacher = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves"
        )
        
        otherLessons = [
            LessonItem(
                id: UUID(),
                lessonType: "Maths",
                subtitle: "Statistics made simple",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "Biology",
                subtitle: "Cranial system; Anatomy",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "English",
                subtitle: "Learning the tenses",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "Physics",
                subtitle: "Motion and mechanics",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            )
        ]
    }
    
    var moreAboutTitle: String {
        "More about the teacher"
    }
    
    var otherLessonsTitle: String {
        "Other lessons"
    }
    
    var pickLessonButtonText: String {
        switch router?.userRole {
        case .teacher: "Edit"
        default: "Save"
        }
    }
    
    func pickLessonButtonAction() {
        guard let router = router else {
            return
        }
        
        switch router.userRole {
        case .teacher: teacherAction()
        case .student: studentAction()
        }
    }
}

private extension LessonPickScreenViewModel {
    func teacherAction() {
        do {
            self.lessonFormViewModel = try LessonFormViewModel(
                lesson: self.pickedLesson,
                formType: FormType.edit,
                dateFormatter: DateFormatter(),
                onCancel: { [weak self] in
                    self?.lessonFormViewModel = nil
                }
            ) { [weak self] lesson in
                self?.pickedLesson = lesson
                self?.lessonFormViewModel = nil
            }
        } catch {
            self.lessonFormViewModel = nil
        }
    }
    
    func studentAction() {
        print("Saving: \(self.pickedLesson)")
    }
}

extension LessonPickScreenViewModel: Equatable {
    static func == (lhs: LessonPickScreenViewModel, rhs: LessonPickScreenViewModel) -> Bool {
        lhs.pickedLesson.id == rhs.pickedLesson.id
    }
}
