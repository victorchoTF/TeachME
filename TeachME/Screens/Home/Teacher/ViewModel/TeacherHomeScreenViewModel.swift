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
    var editLessonFormViewModel: EditLessonFormViewModel?
    
    init(lessons: [LessonItem]) {
        self.lessons = lessons
    }
    
    func onLessonTap(_ lesson: LessonItem?) {
        guard let lesson = lesson else {
            return
        }
        
        self.selectedLesson = lesson
        self.editLessonFormViewModel = EditLessonFormViewModel(lesson: lesson) { [weak self] lesson in
            self?.lessons.removeAll(where: { $0 == self?.selectedLesson })
            self?.lessons.insert(
                lesson,
                at: 0
            )
            
            self?.selectedLesson = nil
            self?.editLessonFormViewModel = nil
        }
    }
}
