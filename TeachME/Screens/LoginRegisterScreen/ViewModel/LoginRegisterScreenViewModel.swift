//
//  LoginRegisterScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

class LoginRegisterScreenViewModel: ObservableObject {
    let registerFormsViewModel: RegisterFormViewModel
    
    init(registerFormsViewModel: RegisterFormViewModel) {
        self.registerFormsViewModel = registerFormsViewModel
    }
}
