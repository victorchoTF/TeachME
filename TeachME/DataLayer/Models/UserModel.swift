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
