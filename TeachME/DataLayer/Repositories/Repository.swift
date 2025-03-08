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
        let data = mapper.modelToData(model)
        
        let result = try await dataSource.create(data)
        
        return mapper.dataToModel(result)
    }
    
    func getById(_ id: UUID) async throws -> ModelType {
        let result = try await dataSource.fetchById(id)
        
        return mapper.dataToModel(result)
    }
    
    func update(_ model: ModelType) async throws {
        let data = mapper.modelToData(model)
        
        try await dataSource.update(data)
    }
    
    func delete(_ id: UUID) async throws {
        try await dataSource.delete(id)
    }
    
    func getAll() async throws -> [ModelType] {
        let dataList = try await dataSource.fetchAll()
        
        var result: [ModelType] = []
        
        for data in dataList {
            result.append(mapper.dataToModel(data))
        }
        
        return result
    }
}
