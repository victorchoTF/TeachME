//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem
    @Published var editProfileFormViewModel: EditProfileFormViewModel?
    
    init(userItem: UserItem) {
        self.userItem = userItem
    }
    
    var editButtonText: String {
        "Edit"
    }
    
    func openEditProfile() {
        editProfileFormViewModel = EditProfileFormViewModel(
            userItem: userItem,
            onCancel: { [weak self] in
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
