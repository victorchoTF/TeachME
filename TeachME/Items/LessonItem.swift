//
//  LessonItem.swift
//  TeachME
//
//  Created by TumbaDev on 28.01.25.
//

import SwiftUI

struct LessonItem: Identifiable, Equatable {
    let id: UUID
    let lessonType: String
    let subtitle: String
    let startDate: String
    let endDate: String
    let teacher: UserLessonBodyItem
    let student: UserLessonBodyItem?
    
    init(
        id: UUID,
        lessonType: String,
        subtitle: String,
        startDate: String,
        endDate: String,
        teacher: UserLessonBodyItem,
        student: UserLessonBodyItem? = nil
    ) {
        self.id = id
        self.lessonType = lessonType
        self.subtitle = subtitle
        self.startDate = startDate
        self.endDate = endDate
        self.teacher = teacher
        self.student = student
    }
}

struct LessonItemBody {
    let lessonType: String
    let subtitle: String
    let startDate: String
    let endDate: String
    let teacher: UserLessonBodyItem
}
