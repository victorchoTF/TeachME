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
    
    func dataToModel(_ data: DataType) -> ModelType
    func modelToData(_ model: ModelType) -> DataType
}
