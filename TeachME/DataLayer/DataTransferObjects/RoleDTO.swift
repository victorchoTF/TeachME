//
//  RoleDTO.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

struct RoleDTO: DataTransferObject {
    let id: UUID
    let title: String
}

struct RoleBodyDTO {
    let title: String
}
