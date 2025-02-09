//
//  UserItem.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import SwiftUI

struct UserItem {
    let name: String
    let profilePicture: Image
    let email: String
    let phoneNumber: String
    let bio: String
    
    init(
        name: String,
        profilePicture: Image = Image(systemName: "person.crop.circle"),
        email: String,
        phoneNumber: String,
        bio: String
    ) {
        self.name = name
        self.profilePicture = profilePicture
        self.email = email
        self.phoneNumber = phoneNumber
        self.bio = bio
    }
}
