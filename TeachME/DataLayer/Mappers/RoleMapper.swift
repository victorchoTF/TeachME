//
//  RoleMapper.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct UnkownRoleError: Error {}

struct RoleMapper: Mapper {
    func dtoToModel(_ data: RoleDTO) -> RoleModel {
        RoleModel(id: data.id, title: data.title)
    }
    
    func modelToDTO(_ model: RoleModel) -> RoleDTO {
        RoleDTO(id: model.id, title: model.title)
    }
    
    func modelToItem(_ model: RoleModel) throws -> Role {
        switch model.title {
        case "Teacher":
            return .teacher
        case "Student":
            return .student
        default:
            throw UnkownRoleError()
        }
    }
}
