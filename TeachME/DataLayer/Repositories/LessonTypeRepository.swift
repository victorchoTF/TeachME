//
//  LessonTypeRepository.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

final class LessonTypeRepository: Repository {
    typealias ModelType = LessonTypeModel
    typealias MapperType = LessonTypeMapper
    typealias DataSource = LessonTypeDataSource
    
    let dataSource: LessonTypeDataSource
    let mapper: LessonTypeMapper
    
    init(dataSource: LessonTypeDataSource, mapper: LessonTypeMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
}
