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
    
    let theme: Theme
    let user: UserItem
    
    init(theme: Theme, user: UserItem) {
        self.theme = theme
        self.user = user
    }
    
}

extension ProfileRouter: Router {
    @MainActor
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel(userItem: user)

        return ProfileScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
