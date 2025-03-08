//
//  LessonTypeMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct LessonTypeMapper: Mapper {
    func dataToModel(_ data: LessonTypeDTO) -> LessonTypeModel {
        LessonTypeModel(id: data.id, name: data.name)
    }
    
    func modelToData(_ model: LessonTypeModel) -> LessonTypeDTO {
        LessonTypeDTO(id: model.id, name: model.name)
    }
}
