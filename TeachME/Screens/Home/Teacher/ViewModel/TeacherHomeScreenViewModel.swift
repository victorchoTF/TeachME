//
//  TeacherHomeScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation

final class TeacherHomeScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem]
    @Published var selectedLesson: LessonItem?
    
    init(lessons: [LessonItem]) {
        self.lessons = lessons
    }
    
    func onLessonTap(_ lesson: LessonItem?) {
        selectedLesson = lesson
    }
}
