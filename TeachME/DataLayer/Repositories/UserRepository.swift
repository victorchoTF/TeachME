//
//  UserRepository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

final class UserRepository: Repository {
    typealias ModelType = UserModel
    typealias MapperType = UserMapper
    typealias DataSource = UserDataSource
    
    let dataSource: UserDataSource
    let mapper: UserMapper
    
    init(dataSource: UserDataSource, mapper: UserMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func getUsersByRoleId(_ id: UUID) async throws -> [UserModel] {
        try await dataSource.getUsersByRoleId(id).map { mapper.dtoToModel($0) }
    }
}
