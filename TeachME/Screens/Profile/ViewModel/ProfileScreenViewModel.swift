//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem?
    @Published var editProfileFormViewModel: EditProfileFormViewModel?
    
    // TODO: Fetch real data
    func loadData() {
        userItem = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves",
            role: .Student
        )
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    func openEditProfile() {
        guard let user = userItem else { return }
        editProfileFormViewModel = EditProfileFormViewModel(userItem: user, onCancel: { [weak self] in
            self?.editProfileFormViewModel = nil
        }) { [weak self] user in
            self?.updateProfile(userItem: user)
        }
    }

    func updateProfile(userItem: UserItem) {
        self.userItem = userItem
        
        editProfileFormViewModel = nil
    }
}
