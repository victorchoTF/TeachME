//
//  UserModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct UserModel: Model {
    let id: UUID
    let email: String
    let firstName: String
    let lastName: String
    let userDetail: UserDetailModel?
    let role: RoleModel
}

struct UserBodyModel {
    let email: String
    let firstName: String
    let lastName: String
    let userDetails: UserDetailBodyModel?
}

struct UserLessonBodyModel: Model {
    let id: UUID
    let firstName: String
    let lastName: String
    let profilePicture: Data?
}

struct UserCredentialsBodyModel {
    let email: String
    let password: String
}

struct UserRegisterBodyModel {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let roleId: UUID
}
