//
//  LoginRegisterScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

class LoginRegisterScreenViewModel: ObservableObject {
    let loginFormViewModel: LoginFormViewModel
    let registerFormsViewModel: RegisterFormViewModel
    
    @Published var mode: FormMode = .login
    
    init(loginFormViewModel: LoginFormViewModel, registerFormsViewModel: RegisterFormViewModel) {
        self.loginFormViewModel = loginFormViewModel
        self.registerFormsViewModel = registerFormsViewModel
    }
}

enum FormMode {
    case login
    case register
    
    mutating func toggle() {
        if self == .register {
            self = .login
            return
        }
        
        self = .register
        
    }
}


