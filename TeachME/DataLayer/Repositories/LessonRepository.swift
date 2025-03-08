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
}
