//
//  LessonPickScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import Foundation

final class LessonPickScreenViewModel {
    let pickedLesson: LessonItem
    let teacher: UserItem
    let otherLessons: [LessonItem]
    
    init(lesson: LessonItem, teacher: UserItem, otherLessons: [LessonItem]) {
        self.pickedLesson = lesson
        self.teacher = teacher
        self.otherLessons = otherLessons
    }
    
    var moreAboutTitle: String {
        "More about the teacher"
    }
    
    var otherLessonsTitle: String {
        "Other lessons"
    }
    
    var pickLessonButtonText: String {
        "Save"
    }
}
