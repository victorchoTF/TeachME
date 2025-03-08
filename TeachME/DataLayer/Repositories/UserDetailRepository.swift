//
//  UserDetailRepository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

final class UserDetailRepository: Repository {
    typealias ModelType = UserDetailModel
    typealias MapperType = UserDetailMapper
    typealias DataSource = UserDetailDataSource
    
    var dataSource: UserDetailDataSource
    var mapper: UserDetailMapper
    
    init(dataSource: UserDetailDataSource, mapper: UserDetailMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
}
