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
    
    func dtoToModel(_ data: LessonDTO) -> LessonModel {
        let studentModel: UserLessonBodyModel?
        
        if let student = data.student {
            studentModel = userMapper.lessonBodyDTOToModel(student)
        } else {
            studentModel = nil
        }
        
        return LessonModel(
            id: data.id,
            lessonType: lessonTypeMapper.dtoToModel(data.lessonType),
            subtitle: data.subtitle,
            startDate: data.startDate,
            endDate: data.endDate,
            teacher: userMapper.lessonBodyDTOToModel(data.teacher),
            student: studentModel
        )
    }
    
    func modelToDTO(_ model: LessonModel) -> LessonDTO {
        let studentData: UserLessonBodyDTO?
        
        if let student = model.student {
            studentData = userMapper.lessonBodyModelToDTO(student)
        } else {
            studentData = nil
        }
        
        return LessonDTO(
            id: model.id,
            lessonType: lessonTypeMapper.modelToDTO(model.lessonType),
            subtitle: model.subtitle,
            startDate: model.startDate,
            endDate: model.endDate,
            teacher: userMapper.lessonBodyModelToDTO(model.teacher),
            student: studentData
        )
    }
}
