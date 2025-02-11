//
//  ProfileRouter.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

class ProfileRouter {
    @Published var path = [Destination]()
    
    let userItem: UserItem
    let theme: Theme
    
    init() {
        theme = PrimaryTheme()
        
        self.userItem = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves"
        )
    }
    
}

extension ProfileRouter: PresentationRouter {
    @MainActor
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel(userItem: userItem)

        return ProfileScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func dismiss() {
        _ = path.popLast()
    }
    
    func open() {
        
    }
}
