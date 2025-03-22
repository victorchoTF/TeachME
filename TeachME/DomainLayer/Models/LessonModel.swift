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
    let startDate: Date
    let endDate: Date
    let teacher: UserLessonBodyModel
    let student: UserLessonBodyModel?
}

struct LessonBodyModel {
    let lessonType: LessonTypeModel
    let subtitle: String
    let startDate: Date
    let endDate: Date
    let teacher: UserLessonBodyModel
    let student: UserLessonBodyModel?
}
