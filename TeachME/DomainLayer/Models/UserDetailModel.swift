//
//  UserDetailModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.03.25.
//

import Foundation

struct UserDetailModel: Model {
    let id: UUID
    let bio: String?
    let profilePicture: Data?
    let phoneNumber: String?
}

struct UserDetailBodyModel {
    let userId: UUID
    let bio: String?
    let profilePicture: Data?
    let phoneNumber: String?
}
