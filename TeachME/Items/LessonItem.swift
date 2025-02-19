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
    
    init(
        id: UUID,
        lessonType: String,
        subtitle: String,
        startDate: String,
        endDate: String,
        teacherProfilePicture: Image,
        teacherName: String
    ) {
        self.id = id
        self.lessonType = lessonType
        self.subtitle = subtitle
        self.startDate = startDate
        self.endDate = endDate
        self.teacherProfilePicture = teacherProfilePicture
        self.teacherName = teacherName
    }
    
    init(teacherName: String, teacherProfilePicture: Image) {
        id = UUID()
        lessonType = "Maths"
        subtitle = ""
        startDate = ""
        endDate = ""
        self.teacherProfilePicture = teacherProfilePicture
        self.teacherName = teacherName
    }
    
    
}
