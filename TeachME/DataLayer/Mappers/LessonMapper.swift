//
//  LessonMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation
import SwiftUI

struct LessonMapper: Mapper {
    let lessonTypeMapper: LessonTypeMapper
    let userMapper: UserMapper
    let dateFormatter: DateFormatter
    
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
            startDate: Date(timeIntervalSince1970: TimeInterval(data.startDate)),
            endDate: Date(timeIntervalSince1970: TimeInterval(data.endDate)),
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
            startDate: Int(model.startDate.timeIntervalSince1970),
            endDate: Int(model.endDate.timeIntervalSince1970),
            teacher: userMapper.lessonBodyModelToDTO(model.teacher),
            student: studentData
        )
    }
    
    func modelToItem(_ model: LessonModel) -> LessonItem {
        return LessonItem(
            id: model.id,
            lessonType: model.lessonType.name,
            subtitle: model.subtitle,
            startDate: dateFormatter.toString(model.startDate),
            endDate: dateFormatter.toString(model.endDate),
            teacherProfilePicture: Image(
                data: model.teacher.profilePicture,
                fallbackImageName: "person.crop.circle"
            ),
            teacherName: "\(model.teacher.firstName) \(model.teacher.lastName)"
        )
    }
}
