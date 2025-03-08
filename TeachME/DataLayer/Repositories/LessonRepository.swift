//
//  LessonRepository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

final class LessonRepository: Repository {
    typealias ModelType = LessonModel
    typealias MapperType = LessonMapper
    typealias DataSource = LessonDataSource
    
    var dataSource: LessonDataSource
    var mapper: LessonMapper
    
    init(dataSource: LessonDataSource, mapper: LessonMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func getOpenLessons() async throws -> [LessonModel] {
        let lessons = try await dataSource.getOpenLessons()
        
        return lessonsToLessonModels(lessons)
    }
    
    func getLessonsByTeacherId(_ id: UUID) async throws -> [LessonModel] {
        let lessons = try await dataSource.getLessonsByTeacherId(id)
        
        return lessonsToLessonModels(lessons)
    }
    
    func getLessonsByStudentId(_ id: UUID) async throws -> [LessonModel] {
        let lessons = try await dataSource.getLessonsByStudentId(id)
        
        return lessonsToLessonModels(lessons)
    }
    
    func getLessonsByLessonTypeId(_ id: UUID) async throws -> [LessonModel] {
        let lessons = try await dataSource.getLessonsByLessonTypeId(id)
        
        return lessonsToLessonModels(lessons)
    }
    
    func takeLesson(lesson: LessonModel) async throws {
        let lessonData = mapper.modelToData(lesson)
        
        try await dataSource.takeLesson(lesson: lessonData)
    }
}

private extension LessonRepository {
    func lessonsToLessonModels(_ lessons: [LessonDTO]) -> [LessonModel] {
        var lessonModels: [LessonModel] = []
        
        for lesson in lessons {
            lessonModels.append(mapper.dataToModel(lesson))
        }
        
        return lessonModels
    }
}
