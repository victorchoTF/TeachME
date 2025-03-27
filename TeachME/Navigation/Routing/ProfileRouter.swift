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
    private let emailValidator: EmailValidator
    private let logOut: () -> ()
    
    init(
        theme: Theme,
        user: UserItem,
        userRepository: UserRepository,
        mapper: UserMapper,
        rolePorvider: RoleProvider,
        emailValidator: EmailValidator,
        logOut: @escaping () -> ()
    ) {
        self.theme = theme
        self.user = user
        self.userRepository = userRepository
        self.mapper = mapper
        self.roleProvider = rolePorvider
        self.emailValidator = emailValidator
        self.logOut = logOut
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
            roleProvider: roleProvider,
            emailValidator: emailValidator,
            logOut: logOut
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
