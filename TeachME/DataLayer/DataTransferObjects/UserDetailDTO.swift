//
//  UserDetailsDTO.swift
//  TeachME
//
//  Created by TumbaDev on 2.03.25.
//

import Foundation

struct UserDetailDTO: DataTransferObject {
    let id: UUID
    let bio: String?
    let profilePicture: Data?
    let phoneNumber: String?
}

struct UserDetailBodyDTO: Encodable {
    let userId: UUID
    let bio: String?
    let profilePicture: Data?
    let phoneNumber: String?
}
