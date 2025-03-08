//
//  LessonMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct LessonMapper: Mapper {
    let lessonTypeMapper: LessonTypeMapper
    let userMapper: UserMapper
    
    func dataToModel(_ data: LessonDTO) -> LessonModel {
        let studentModel: UserLessonBodyModel?
        
        if let student = data.student {
            studentModel = userMapper.lessonBodyDataToModel(student)
        } else {
            studentModel = nil
        }
        
        return LessonModel(
            id: data.id,
            lessonType: lessonTypeMapper.dataToModel(data.lessonType),
            subtitle: data.subtitle,
            startDate: data.startDate,
            endDate: data.endDate,
            teacher: userMapper.lessonBodyDataToModel(data.teacher),
            student: studentModel
        )
    }
    
    func modelToData(_ model: LessonModel) -> LessonDTO {
        let studentData: UserLessonBodyDTO?
        
        if let student = model.student {
            studentData = userMapper.lessonBodyModelToData(student)
        } else {
            studentData = nil
        }
        
        return LessonDTO(
            id: model.id,
            lessonType: lessonTypeMapper.modelToData(model.lessonType),
            subtitle: model.subtitle,
            startDate: model.startDate,
            endDate: model.endDate,
            teacher: userMapper.lessonBodyModelToData(model.teacher),
            student: studentData
        )
    }
}
