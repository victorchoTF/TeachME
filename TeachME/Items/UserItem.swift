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
        name: String = "default",
        profilePicture: Image = Image(systemName: "person.crop.circle"),
        email: String = "default",
        phoneNumber: String = "default",
        bio: String = "default"
    ) {
        self.name = name
        self.profilePicture = profilePicture
        self.email = email
        self.phoneNumber = phoneNumber
        self.bio = bio
    }
}
