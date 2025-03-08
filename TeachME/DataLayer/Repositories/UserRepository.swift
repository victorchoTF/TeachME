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
    
    var dataSource: UserDataSource
    var mapper: UserMapper
    
    init(dataSource: UserDataSource, mapper: UserMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
}
