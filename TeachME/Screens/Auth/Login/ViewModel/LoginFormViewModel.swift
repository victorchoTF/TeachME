//
//  LoginFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import Foundation

final class LoginFormViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    var formTitle: String {
        "Learning and teaching made simple"
    }
    
    var formType: String {
        "Log In"
    }
    
    var emailPlaceholder: String {
        "Email"
    }
    
    var passwordPlaceholder: String {
        "Password"
    }
    
    var noAccount: String {
        "Don't have an account?"
    }
    
    var formTransitionPrompt: String {
        "Create one!"
    }
    
    var sendTo: FormMode {
        .register
    }
}
