//
//  ProfileScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation

final class ProfileScreenViewModel: ObservableObject {
    @Published var userItem: UserItem?
    
    init(userItem: UserItem) {
        self.userItem = userItem
    }
}
