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
    
    let dataSource: LessonDataSource
    let mapper: LessonMapper
    
    init(dataSource: LessonDataSource, mapper: LessonMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func create(_ body: LessonBodyModel) async throws -> LessonModel {
        try await mapper.dtoToModel(
            dataSource.create(
                mapper.bodyModelToBodyDTO(body)
            )
        )
    }
    
    func update(_ model: LessonBodyModel, id: UUID) async throws {
        try await dataSource.update(mapper.bodyModelToBodyDTO(model), id: id)
    }
    
    func getOpenLessons() async throws -> [LessonModel] {
        try await dataSource.getOpenLessons().map {mapper.dtoToModel($0)}
    }
    
    func getLessonsByTeacherId(_ id: UUID) async throws -> [LessonModel] {
        try await dataSource.getLessonsByTeacherId(id).map {mapper.dtoToModel($0)}
    }
    
    func getLessonsByStudentId(_ id: UUID) async throws -> [LessonModel] {
        try await dataSource.getLessonsByStudentId(id).map {mapper.dtoToModel($0)}
    }
    
    func getLessonsByLessonTypeId(_ id: UUID) async throws -> [LessonModel] {
        try await dataSource.getLessonsByLessonTypeId(id).map {mapper.dtoToModel($0)}
    }
    
    func takeLesson(_ body: LessonBodyModel, id: UUID) async throws {
        try await dataSource.takeLesson(mapper.bodyModelToBodyDTO(body), id: id)
    }
    
    func cancelLesson(_ body: LessonBodyModel, id: UUID) async throws {
        try await dataSource.takeLesson(mapper.bodyModelToBodyDTO(body), id: id)
    }
}
