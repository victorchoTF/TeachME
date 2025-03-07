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
    let teacher: UserLessonBodyDTO
    let student: UserLessonBodyDTO?
}

struct UserLessonBodyDTO: DataTransferObject {
    let id: UUID
    let firstName: String
    let lastName: String
}
