//
//  LessonTypeModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct LessonTypeModel: Model {
    let id: UUID
    let name: String
}

struct LessonTypeBodyModel {
    let name: String
}
