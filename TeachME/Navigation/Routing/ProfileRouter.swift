//
//  ProfileRouter.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

class ProfileRouter: ObservableObject {
    @Published var path = [Destination]()
    @Published var user: UserItem
    
    let theme: Theme
    
    let userRepository: UserRepository
    let mapper: UserMapper
    
    private let roleProvider: RoleProvider
    
    init(
        theme: Theme,
        user: UserItem,
        userRepository: UserRepository,
        mapper: UserMapper,
        rolePorvider: RoleProvider
    ) {
        self.theme = theme
        self.user = user
        self.userRepository = userRepository
        self.mapper = mapper
        self.roleProvider = rolePorvider
    }
    
}

extension ProfileRouter: Router {
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel(
            router: self,
            user: user,
            userRepository: userRepository,
            mapper: mapper,
            imageFormatter: ImageFormatter(),
            roleProvider: roleProvider
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
