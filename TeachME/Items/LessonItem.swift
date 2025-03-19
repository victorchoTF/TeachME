//
//  LessonItem.swift
//  TeachME
//
//  Created by TumbaDev on 28.01.25.
//

import SwiftUI

struct LessonItem: Identifiable {
    let id: UUID
    let lessonType: String
    let subtitle: String
    let startDate: String
    let endDate: String
    let teacher: UserLessonBodyItem
}

extension LessonItem: Equatable {
    static func == (lhs: LessonItem, rhs: LessonItem) -> Bool {
        lhs.id == rhs.id &&
        lhs.lessonType == rhs.lessonType &&
        lhs.subtitle == rhs.subtitle &&
        lhs.startDate == rhs.startDate &&
        lhs.endDate == rhs.endDate &&
        lhs.teacher.name == rhs.teacher.name &&
        lhs.teacher.profilePicture == rhs.teacher.profilePicture
    }
}
