//
//  Mapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

protocol Mapper {
    associatedtype DataType: DataTransferObject
    associatedtype ModelType: Model
    
    func dtoToModel(_ data: DataType) -> ModelType
    func modelToDTO(_ model: ModelType) -> DataType
}
