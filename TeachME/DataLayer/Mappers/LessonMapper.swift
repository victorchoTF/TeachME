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
    
    func modelToItem(_ model: LessonModel) -> LessonItem {
        guard let profilePictureData = model.teacher.profilePicture,
              let image = UIImage(data: profilePictureData) else {
            return LessonItem(
                id: model.id,
                lessonType: model.lessonType.name,
                subtitle: model.subtitle,
                startDate: dateFormatter.toString(
                    Date(timeIntervalSince1970: TimeInterval(model.startDate))
                ),
                endDate: dateFormatter.toString(
                    Date(timeIntervalSince1970: TimeInterval(model.endDate))
                ),
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "\(model.teacher.firstName) \(model.teacher.lastName)"
            )
        }
        
        return LessonItem(
            id: model.id,
            lessonType: model.lessonType.name,
            subtitle: model.subtitle,
            startDate: dateFormatter.toString(
                Date(timeIntervalSince1970: TimeInterval(model.startDate))
            ),
            endDate: dateFormatter.toString(
                Date(timeIntervalSince1970: TimeInterval(model.endDate))
            ),
            teacherProfilePicture: Image(uiImage: image),
            teacherName: "\(model.teacher.firstName) \(model.teacher.lastName)"
        )
    }
}
