//
//  Repository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

protocol Repository {
    associatedtype ModelType: Model
    associatedtype MapperType: Mapper where MapperType.ModelType == ModelType
    associatedtype DataSource: APIDataSource where DataSource.DataType == MapperType.DataType

    
    var dataSource: DataSource { get }
    var mapper: MapperType { get }
    
    func create(_ model: ModelType) async throws -> ModelType
    func getById(_ id: UUID) async throws -> ModelType
    func update(_ model: ModelType) async throws
    func delete(_ id: UUID) async throws
    func getAll() async throws -> [ModelType]
}

extension Repository {
    func create(_ model: ModelType) async throws -> ModelType {
        try await mapper.dataToModel(dataSource.create(mapper.modelToData(model)))
    }
    
    func getById(_ id: UUID) async throws -> ModelType {
        try await mapper.dataToModel(dataSource.fetchById(id))
    }
    
    func update(_ model: ModelType) async throws {
        try await dataSource.update(mapper.modelToData(model))
    }
    
    func delete(_ id: UUID) async throws {
        try await dataSource.delete(id)
    }
    
    func getAll() async throws -> [ModelType] {
        try await dataSource.fetchAll().map { mapper.dataToModel($0) }
    }
}
