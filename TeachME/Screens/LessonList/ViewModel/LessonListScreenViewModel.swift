//
//  StudentHomeScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation

final class LessonListScreenViewModel {
    let lessons: [LessonItem]
    
    private weak var router: LessonsRouter?
    
    init(lessons: [LessonItem], router: LessonsRouter?) {
        self.lessons = lessons
        self.router = router
    }
    
    func onLessonTap(lesson: LessonItem) {
        guard let router = router else {
            return
        }
        
        router.onLessonTapped(lesson: lesson)
    }
}
