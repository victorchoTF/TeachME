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
    let profilePicture: Data?
}

struct UserBodyDTO: Encodable {
    let email: String
    let firstName: String
    let lastName: String
    let userDetails: UserDetailBodyDTO?
}

struct UserCredentialsBodyDTO: Codable {
    let email: String
    let password: String
}

struct UserRegisterBodyDTO: Codable {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let roleId: UUID
}
