//
//  LoginFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import Foundation

class LoginFormViewModel: ObservableObject {
    @Published var loginFields: LoginFields
    
    init(loginFields: LoginFields) {
        self.loginFields = loginFields
    }
    
    var formTitle: String {
        "Learning and teaching made simple"
    }
    
    var formType: String {
        "Log In"
    }
    
    var email: String {
        "Email"
    }
    
    var password: String {
        "Password"
    }
    
    var noAccount: String {
        "Don't have an account?"
    }
    
    var formTransitionPrompt: String {
        "Create one!"
    }
}
