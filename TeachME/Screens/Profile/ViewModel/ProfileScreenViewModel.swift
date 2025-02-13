//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import SwiftUI

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem?
    @Published var isEditingProfile: Bool = false
    @Published var editProfileFormViewModel: EditProfileFormViewModel? = nil

    init() {
        loadData()
    }
    
    func loadData() {
        userItem = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves"
        )
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    func openEditProfile() {
        guard let user = userItem else { return }
        editProfileFormViewModel = EditProfileFormViewModel(userItem: user) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.saveProfile()
        }
        isEditingProfile = true
    }

    func saveProfile() {
        if let user = userItem {
            userItem = editProfileFormViewModel?.userFromForm(user: user)
        }
        
        isEditingProfile = false
    }
}
