//
//  StudentHomeScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation

final class LessonListScreenViewModel {
    let lessons: [LessonItem]
    
    init(lessons: [LessonItem]) {
        self.lessons = lessons
    }
}
