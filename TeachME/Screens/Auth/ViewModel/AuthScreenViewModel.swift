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

@MainActor final class AuthScreenViewModel: ObservableObject {
    let loginFormViewModel: LoginFormViewModel
    let registerFormsViewModel: RegisterFormViewModel
    
    @Published var mode: FormMode = .login
    
    init(
        loginFormViewModel: LoginFormViewModel,
        registerFormsViewModel: RegisterFormViewModel
    ) {
        self.loginFormViewModel = loginFormViewModel
        self.registerFormsViewModel = registerFormsViewModel
    }
    
    func switchToRegister() {
        mode = loginFormViewModel.sendTo
    }
    
    func switchToLogin() {
        mode = registerFormsViewModel.sendTo
    }
}
