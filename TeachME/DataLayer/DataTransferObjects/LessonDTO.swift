//
//  LessonDTO.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

struct LessonDTO: DataTransferObject {
    let id: UUID
    let lessonType: LessonTypeDTO
    let subtitle: String
    let startDate: Int
    let endDate: Int
    let teacher: UserLessonBody
    let student: UserLessonBody?
}

struct UserLessonBody: Codable {
    let id: UUID
    let firstName: String
    let lastName: String
}
