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
        "Learning made simple"
    }
    
    var formType: String {
        "Login"
    }
    
    var email: String {
        "Email"
    }
    
    var password: String {
        "Password"
    }
}
