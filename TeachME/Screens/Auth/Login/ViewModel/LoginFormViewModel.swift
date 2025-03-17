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
    
    private let repository: AuthRepository
    private let userRepository: UserRepository
    private let userMapper: UserMapper
    
    let onSubmit: (UserItem) -> ()
    
    init(
        repository: AuthRepository,
        userRepository: UserRepository,
        userMapper: UserMapper,
        onSubmit: @escaping (UserItem) -> ()
    ) {
        self.repository = repository
        self.userRepository = userRepository
        self.userMapper = userMapper
        self.onSubmit = onSubmit
    }

    func loginUser() {
        Task {
            let _ = try await repository.login(
                user: UserCredentialsBodyModel(
                    email: email,
                    password: password
                )
            )
                
            let userItem = try await userMapper.modelToItem(
                userRepository.getUserByEmail(email)
            )
            
            onSubmit(userItem)
        }
    }
    
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
