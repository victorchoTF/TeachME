//
//  RegisterFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

class RegisterFormViewModel: ObservableObject {
    @Published var registerFields: RegisterFields
    
    init(registerFields: RegisterFields) {
        self.registerFields = registerFields
    }
    
    var roleSelection: Role {
        registerFields.roleType
    }
    
    var formTitle: String {
        "Start your knoledge journey today!"
    }
    
    var formType: String {
        "Register"
    }
    
    var accountDetailsHeading: String {
        "Account Details"
    }
    
    var email: String {
        "Email"
    }
    
    var password: String {
        "Password"
    }
    
    var personalDetailsHeading: String {
        "Personal Details"
    }
    
    var name: String {
        "Name"
    }
    
    var lastName: String {
        "Last Name"
    }
    
    var roleHeading: String {
        "Role"
    }
    
    var studentRole: String {
        Role.student.rawValue
    }
    
    var teacherRole: String {
        Role.teacher.rawValue
    }
    
    var hasAccount: String {
        "Already have an account?"
    }
    
    var formTransitionPrompt: String {
        "Log In!"
    }
}
