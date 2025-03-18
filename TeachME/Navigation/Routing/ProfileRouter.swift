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
    
    let authRepository: UserRepository
    let mapper: UserMapper
    
    init(theme: Theme, user: UserItem, authRepository: UserRepository, mapper: UserMapper) {
        self.theme = theme
        self.user = user
        self.authRepository = authRepository
        self.mapper = mapper
    }
    
}

extension ProfileRouter: Router {
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel(
            userItem: user,
            authRepository: authRepository,
            mapper: mapper
        )

        return ProfileScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
