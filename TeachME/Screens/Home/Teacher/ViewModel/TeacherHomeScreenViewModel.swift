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
        self.editLessonFormViewModel = EditLessonFormViewModel(lesson: lesson) { [weak self] in
            guard let self = self else {
                return
            }
            
            guard let editLessonFormViewModel = self.editLessonFormViewModel else {
                return
            }
            
            self.lessons.removeAll(where: { $0 == lesson })
            self.lessons.insert(
                editLessonFormViewModel.lessonFromForm(),
                at: 0
            )
            
            self.selectedLesson = nil
        }
    }
}
