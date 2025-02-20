//
//  StudentHomeScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation
import SwiftUI

final class LessonListScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem]
    
    private weak var router: HomeRouter?
    @Published var lessonFormViewModel: LessonFormViewModel?
    
    @Published var userItem: UserItem?
    
    init(lessons: [LessonItem], router: HomeRouter) {
        self.lessons = lessons
        self.router = router
    }
    
    func loadData() {
        userItem = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves"
        )
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
        router?.userRole == .teacher
    }
    
    var addButtonIcon: Image {
        Image(systemName: "plus")
    }
    
    func onAddButtonTap() {
        guard let userItem = userItem else {
            return
        }
        
        do {
            self.lessonFormViewModel = try LessonFormViewModel(
                lesson: LessonItem(
                    teacherName: userItem.name,
                    teacherProfilePicture: userItem.profilePicture
                ),
                formType: FormType.add,
                dateFormatter: DateFormatter(),
                onCancel: { [weak self] in
                    self?.lessonFormViewModel = nil
                }
            ) { [weak self] lesson in
                self?.lessons.removeAll(where: { $0 == lesson })
                self?.lessons.insert(
                    lesson,
                    at: 0
                )
                self?.lessonFormViewModel = nil
            }
        } catch {
            self.lessonFormViewModel = nil
        }
    }
}
