//
//  AuthRouter.swift
//  TeachME
//
//  Created by TumbaDev on 18.03.25.
//

import Foundation
import SwiftUI

@MainActor final class AuthRouter: ObservableObject {
    @Published var path = [Destination]()
    @Published var isLoggedIn: Bool = false // TODO: Don't hardcode it
    
    private let theme: Theme
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    private let roleRepository: RoleRepository
    private let userMapper: UserMapper
    
    init(
        theme: Theme,
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        userMapper: UserMapper
    ) {
        self.theme = theme
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.userMapper = userMapper
    }
}

extension AuthRouter {
    var initialDestination: some View {
        let loginFormViewModel = LoginFormViewModel(
            authRepository: authRepository,
            userRepository: userRepository,
            userMapper: userMapper
        ) { userItem in
            self.isLoggedIn = true
        }
        
        let registerFormViewModel = RegisterFormViewModel(
            authRepository: authRepository,
            userRepository: userRepository,
            roleRepository: roleRepository,
            userMapper: userMapper
        ) { userItem in
            self.isLoggedIn = true
        }
        
        let viewModel = AuthScreenViewModel(
            loginFormViewModel: loginFormViewModel,
            registerFormsViewModel: registerFormViewModel
        )

        return AuthScreen(viewModel: viewModel, theme: theme)
    }
}
