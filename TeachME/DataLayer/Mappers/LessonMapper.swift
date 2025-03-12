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
            studentModel = userMapper.lessonBodyDataToModel(student)
        } else {
            studentModel = nil
        }
        
        return LessonModel(
            id: data.id,
            lessonType: lessonTypeMapper.dtoToModel(data.lessonType),
            subtitle: data.subtitle,
            startDate: Date(timeIntervalSince1970: TimeInterval(data.startDate)),
            endDate: Date(timeIntervalSince1970: TimeInterval(data.endDate)),
            teacher: userMapper.lessonBodyDataToModel(data.teacher),
            student: studentModel
        )
    }
    
    func modelToDTO(_ model: LessonModel) -> LessonDTO {
        let studentData: UserLessonBodyDTO?
        
        if let student = model.student {
            studentData = userMapper.lessonBodyModelToData(student)
        } else {
            studentData = nil
        }
        
        return LessonDTO(
            id: model.id,
            lessonType: lessonTypeMapper.modelToDTO(model.lessonType),
            subtitle: model.subtitle,
            startDate: Int(model.startDate.timeIntervalSince1970),
            endDate: Int(model.endDate.timeIntervalSince1970),
            teacher: userMapper.lessonBodyModelToData(model.teacher),
            student: studentData
        )
    }
}
