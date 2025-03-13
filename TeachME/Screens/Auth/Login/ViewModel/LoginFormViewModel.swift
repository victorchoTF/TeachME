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
    
    let onSubmit: (UserItem) -> ()
    
    init(
        repository: AuthRepository,
        onSubmit: @escaping (UserItem) -> ()
    ) {
        self.repository = repository
        self.onSubmit = onSubmit
    }
    
    func loginUser() async throws -> TokenResponse {
        let token = try await repository.login(
            user: UserCredentialsBodyModel(
                email: email,
                password: password
            )
        )
        
        // TODO: Fix after implementing get by email on API
        onSubmit(UserItem(
            name: "...",
            email: email,
            phoneNumber: "",
            bio: "...",
            role: .Student // FIXME: Real bug before having getByEmail()
        ))
        
        return token
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
