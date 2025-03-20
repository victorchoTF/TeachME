//
//  UserItem.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import SwiftUI

struct UserItem {
    let id: UUID
    let name: String
    let profilePicture: Image
    let email: String
    let phoneNumber: String
    let bio: String
    let role: Role
    
    init(
        id: UUID,
        name: String,
        profilePicture: Image = Image(systemName: "person.crop.circle"),
        email: String,
        phoneNumber: String,
        bio: String,
        role: Role
    ) {
        self.id = id
        self.name = name
        self.profilePicture = profilePicture
        self.email = email
        self.phoneNumber = phoneNumber
        self.bio = bio
        self.role = role
    }
}

struct UserLessonBodyItem: Identifiable, Equatable {
    let id: UUID
    let name: String
    let profilePicture: Image
}
