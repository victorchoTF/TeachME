//
//  StudentHomeScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation

final class LessonListScreenViewModel {
    let lessons: [LessonItem]
    let onLessonTapped: (LessonItem) -> ()
    
    init(
        lessons: [LessonItem],
        onLessonTapped: @escaping(LessonItem) -> ()
    ) {
        self.lessons = lessons
        self.onLessonTapped = onLessonTapped
    }
}
