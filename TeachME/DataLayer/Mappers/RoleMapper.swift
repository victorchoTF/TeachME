//
//  RoleMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct RoleMapper: Mapper {
    func dataToModel(_ data: RoleDTO) -> RoleModel {
        RoleModel(id: data.id, title: data.title)
    }
    
    func modelToData(_ model: RoleModel) -> RoleDTO {
        RoleDTO(id: model.id, title: model.title)
    }
}
