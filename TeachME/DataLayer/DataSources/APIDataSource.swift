//
//  DataSource.swift
//  TeachME
//
//  Created by TumbaDev on 28.02.25.
//

import Foundation

protocol APIDataSource {
    associatedtype DataType: DataTransferObject
    
    var client: HTTPClient { get }
    var baseURL: String { get }
    
    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }
    
    func create(_ data: DataType) async throws -> DataType
    func fetchById(_ id: UUID) async throws -> DataType
    func update(_ data: DataType) async throws
    func delete(_ id: UUID) async throws
    func fetchAll() async throws -> [DataType]
}
