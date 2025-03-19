//
//  AuthRouter.swift
//  TeachME
//
//  Created by TumbaDev on 18.03.25.
//

import Foundation
import SwiftUI

class AuthRouter: ObservableObject {
    @Published var path = [Destination]()
    @Published var isLoggedIn: Bool = false // TODO: Don't hardcode it
    
    let theme: Theme
    let authRepository: AuthRepository
    let userRepository: UserRepository
    let roleRepository: RoleRepository
    let userMapper: UserMapper
    
    let onSubmit: (UserItem) -> ()
    
    init(
        theme: Theme,
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        userMapper: UserMapper,
        onSubmit: @escaping (UserItem) -> ()
    ) {
        self.theme = theme
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.userMapper = userMapper
        self.onSubmit = onSubmit
    }
}

extension AuthRouter {
    var initialDestination: some View {
        let loginFormViewModel = LoginFormViewModel(
            authRepository: authRepository,
            userRepository: userRepository,
            userMapper: userMapper
        ) { [weak self] userItem in
            self?.isLoggedIn = true
            self?.onSubmit(userItem)
        }
        
        let registerFormViewModel = RegisterFormViewModel(
            authRepository: authRepository,
            userRepository: userRepository,
            roleRepository: roleRepository,
            userMapper: userMapper
        ) { [weak self] userItem in
            self?.isLoggedIn = true
            self?.onSubmit(userItem)
        }
        
        let viewModel = AuthScreenViewModel(
            loginFormViewModel: loginFormViewModel,
            registerFormsViewModel: registerFormViewModel
        )

        return AuthScreen(viewModel: viewModel, theme: theme)
    }
}
