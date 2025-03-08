//
//  UserDTO.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

struct UserDTO: DataTransferObject {
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
    let userDetail: UserDetailDTO?
    let role: RoleDTO
}

struct UserLessonBodyDTO: DataTransferObject {
    let id: UUID
    let firstName: String
    let lastName: String
}
