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
    
    private let lessonTypeRepository: LessonTypeRepository
    
    private weak var router: HomeRouter?
    
    init(
        pickedLesson: LessonItem,
        router: HomeRouter,
        lessonTypeRepository: LessonTypeRepository
    ) {
        self.pickedLesson = pickedLesson
        self.router = router
        self.lessonTypeRepository = lessonTypeRepository
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
                    lessonTypeRepository: lessonTypeRepository
                ),
                theme
            )
        )
    }
    
    // TODO: Should load real data in future
    func loadData() {
        teacher = UserItem(
            id: UUID(),
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves",
            role: .Student
        )
        
        otherLessons = [
        ]
    }
    
    var moreAboutTitle: String {
        "More about the teacher"
    }
    
    var otherLessonsTitle: String {
        "Other lessons"
    }
    
    var pickLessonButtonText: String {
        switch router?.user?.role {
        case .Teacher: "Edit"
        default: "Save"
        }
    }
    
    func pickLessonButtonAction() {
        guard let user = router?.user else {
            return
        }
        
        switch user.role {
        case .Teacher: teacherAction()
        case .Student: studentAction()
        }
    }
}

private extension LessonPickScreenViewModel {
    func teacherAction() {
        self.lessonFormViewModel = LessonFormViewModel(
            lesson: self.pickedLesson,
            teacher: self.pickedLesson.teacher,
            formType: FormType.edit,
            repository: lessonTypeRepository,
            dateFormatter: DateFormatter(),
            onCancel: { [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            self?.pickedLesson = lesson
            self?.lessonFormViewModel = nil
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
