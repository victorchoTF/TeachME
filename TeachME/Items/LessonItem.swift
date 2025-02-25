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
    let teacherProfilePicture: Image
    let teacherName: String
}
