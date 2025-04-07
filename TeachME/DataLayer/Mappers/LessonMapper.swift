//
//  LessonMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

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
        let studentItem: UserLessonBodyItem?
        if let student = model.student {
            studentItem = UserLessonBodyItem(
                id: student.id,
                name: "\(student.firstName) \(student.lastName)",
                profilePicture: Image(
                    data: student.profilePicture,
                    fallbackImageName: "person.crop.circle"
                )
            )
        } else {
            studentItem = nil
        }
        
        return LessonItem(
            id: model.id,
            lessonType: model.lessonType.name,
            subtitle: model.subtitle,
            startDate: dateFormatter.toString(model.startDate),
            endDate: dateFormatter.toString(model.endDate),
            teacher: UserLessonBodyItem(
                id: model.teacher.id,
                name: "\(model.teacher.firstName) \(model.teacher.lastName)",
                profilePicture: Image(
                    data: model.teacher.profilePicture,
                    fallbackImageName: "person.crop.circle"
                )
            ),
            student: studentItem
        )
    }
    
    func itemToBodyModel(
        _ item: LessonItemBody,
        lessonTypeModel: LessonTypeModel,
        teacherItem: UserLessonBodyModel
    ) throws -> LessonBodyModel {
        guard let startDate = dateFormatter.toDate(dateString: item.startDate) else {
            throw LessonMapperError.invalidDate("\(item.startDate) is not a valid Date!")
        }
        
        guard let endDate = dateFormatter.toDate(dateString: item.endDate) else {
            throw LessonMapperError.invalidDate("\(item.endDate) is not a valid Date!")
        }
        
        return LessonBodyModel(
            lessonType: lessonTypeModel,
            subtitle: item.subtitle,
            startDate: startDate,
            endDate: endDate,
            teacher: teacherItem,
            student: nil
        )
    }
    
    func itemToItemBody(_ item: LessonItem) -> LessonItemBody {
        LessonItemBody(
            lessonType: item.lessonType,
            subtitle: item.subtitle,
            startDate: item.startDate,
            endDate: item.endDate,
            teacher: item.teacher
        )
    }
    
    func bodyModelToBodyDTO(_ model: LessonBodyModel) -> LessonBodyDTO {
        LessonBodyDTO(
            lessonTypeId: model.lessonType.id,
            subtitle: model.subtitle,
            startDate: Int(model.startDate.timeIntervalSince1970),
            endDate: Int(model.endDate.timeIntervalSince1970),
            teacherId: model.teacher.id,
            studentId: model.student?.id
        )
    }
}

enum LessonMapperError: Error {
    case invalidDate(String)
}
