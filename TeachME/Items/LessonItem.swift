//
//  LessonItem.swift
//  TeachME
//
//  Created by TumbaDev on 28.01.25.
//

import Foundation

struct LessonItem: Identifiable {
    let id: UUID
    let lessonType: String
    let subtitle: String
    let startDate: String
    let endDate: String
    let teacherName: String
}
