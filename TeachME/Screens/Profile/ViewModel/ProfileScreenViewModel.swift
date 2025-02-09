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
    
    init(userItem: UserItem) {
        self.userItem = userItem
    }
    
    var editButtonText: String {
        "Edit"
    }
}
