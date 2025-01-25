//
//  LoginRegisterScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

enum FormMode {
    case login
    case register
}

final class AuthScreenViewModel: ObservableObject {
    let loginFormViewModel: LoginFormViewModel
    let registerFormsViewModel: RegisterFormViewModel
    let theme: Theme
    
    @Published var mode: FormMode = .login
    
    init(
        loginFormViewModel: LoginFormViewModel,
        registerFormsViewModel: RegisterFormViewModel,
        theme: Theme
    ) {
        self.loginFormViewModel = loginFormViewModel
        self.registerFormsViewModel = registerFormsViewModel
        self.theme = theme
    }
    
    func switchToRegister() {
        mode = loginFormViewModel.sendTo
    }
    
    func switchToLogin() {
        mode = registerFormsViewModel.sendTo
    }
}
