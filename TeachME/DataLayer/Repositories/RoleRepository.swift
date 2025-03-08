//
//  RoleRepository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

final class RoleRepository: Repository {
    typealias ModelType = RoleModel
    typealias MapperType = RoleMapper
    typealias DataSource = RoleDataSource
    
    let dataSource: RoleDataSource
    let mapper: RoleMapper
    
    init(dataSource: RoleDataSource, mapper: RoleMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
}
