//
//  LessonModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct LessonModel: Model {
    let id: UUID
    let lessonType: LessonTypeModel
    let subtitle: String
    let startDate: Int
    let endDate: Int
    let teacher: UserLessonBodyModel
    let student: UserLessonBodyModel?
}
