//
//  RoleMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct RoleMapper: Mapper {
    func dtoToModel(_ data: RoleDTO) -> RoleModel {
        RoleModel(id: data.id, title: data.title)
    }
    
    func modelToDTO(_ model: RoleModel) -> RoleDTO {
        RoleDTO(id: model.id, title: model.title)
    }
    
    func createBodyModelToCreateBodyDTO(_ model: RoleCreateBodyModel) -> RoleCreateBodyDTO {
        RoleCreateBodyDTO(title: model.title)
    }

}
