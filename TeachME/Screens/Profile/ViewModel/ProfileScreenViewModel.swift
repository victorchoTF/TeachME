//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem?
    @Published var isEditingProfile: Bool = false
    @Published var editProfileFormViewModel: EditProfileFormViewModel? = nil

    init(userItem: UserItem?) {
        self.userItem = userItem
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
