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
    @Published var user: UserItem
    
    let theme: Theme
    
    let userRepository: UserRepository
    let mapper: UserMapper
    
    init(
        theme: Theme,
        user: UserItem,
        userRepository: UserRepository,
        mapper: UserMapper
    ) {
        self.theme = theme
        self.user = user
        self.userRepository = userRepository
        self.mapper = mapper
    }
    
}

extension ProfileRouter: Router {
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel(
            router: self,
            userRepository: userRepository,
            mapper: mapper,
            imageFormatter: ImageFormatter()
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
