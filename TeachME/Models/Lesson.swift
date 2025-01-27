//
//  File.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import Foundation

struct LessonDisplay: Identifiable {
    let id: UUID
    let lessonType: String
    let subtitle: String
    let startDate: String
    let endDate: String
    let teacherName: String
}
