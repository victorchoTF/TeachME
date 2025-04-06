//
//  LoginFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import Foundation

@MainActor final class LoginFormViewModel: ObservableObject {
    @Published var alertItem: AlertItem? = nil
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    private let userMapper: UserMapper

    private let emailValidator: EmailValidator
    
    @Published var hasTriedInvalidEmail: Bool = false
    @Published var isPasswordFieldSecure: Bool = true
    
    let onSubmit: (UserItem) -> ()
    
    init(
        authRepository: AuthRepository,
        userRepository: UserRepository,
        userMapper: UserMapper,
        emailValidator: EmailValidator,
        onSubmit: @escaping (UserItem) -> ()
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.userMapper = userMapper
        self.emailValidator = emailValidator
        self.onSubmit = onSubmit
    }

    func loginUser() {
        guard isEmailValid else {
            hasTriedInvalidEmail = true
            email = ""
            return
        }
        
        Task {
            do {
                let _ = try await authRepository.login(
                    user: UserCredentialsBodyModel(
                        email: email,
                        password: password
                    )
                )
            } catch {
                if case UserExperienceError.invalidCredentials = error {
                    alertItem = AlertItem(alertType: .invalidCredentials)
                } else {
                    alertItem = AlertItem(alertType: .error)
                }
            }
            
            let userItem = try await userMapper.modelToItem(userRepository.getUserByEmail(email))
            
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
        if hasTriedInvalidEmail {
            return "Please enter a valid email"
        }
        
        return "Email"
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
    
    var isEmailValid: Bool {
        emailValidator.isValid(email: email)
    }
    
    func resetEmailError() {
        hasTriedInvalidEmail = false
    }
}
