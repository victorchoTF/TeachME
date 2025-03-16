//
//  LessonTypeDTO.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

struct LessonTypeDTO: DataTransferObject {
    let id: UUID
    let name: String
}

struct LessonTypeCreateBodyDTO: Encodable {
    let name: String
}
