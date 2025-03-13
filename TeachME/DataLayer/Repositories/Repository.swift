//
//  Repository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

protocol Repository {
    associatedtype ModelType: Model
    
    var dataSource: any APIDataSource { get }
    
    func create(_ model: ModelType) async throws -> ModelType
    func getById(_ id: UUID) async throws -> ModelType
    func update(_ model: ModelType) async throws
    func delete(_ id: UUID) async throws
    func getAll() async throws -> [ModelType]
}
