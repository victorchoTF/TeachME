//
//  RegisterFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

final class RegisterFormViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var roleType: Role = .Student
    
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
    func registerUser() async throws -> TokenResponse {
        guard let roleId = UUID(uuidString: roleType.rawValue) else {
            throw RegisterFormError.invalidRoleID
        }
        
        let token = try await repository.register(
            user: UserRegisterBodyModel(
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName,
                roleId: roleId
            )
        )
        
        let userItem = try await userMapper.modelToItem(userRepository.getUserByEmail(email))
        
        onSubmit(userItem)
        
        return token
    }
    
    var roleSelection: Role {
        roleType
    }
    
    var formTitle: String {
        "Start your knowledge journey today!"
    }
    
    var formType: String {
        "Register"
    }
    
    var accountDetailsHeading: String {
        "Account Details"
    }
    
    var emailPlaceholder: String {
        "Email"
    }
    
    var passwordPlacehoder: String {
        "Password"
    }
    
    var personalDetailsHeading: String {
        "Personal Details"
    }
    
    var namePlaceholder: String {
        "Name"
    }
    
    var lastNamePlaceholder: String {
        "Last Name"
    }
    
    var roleHeading: String {
        "Role"
    }
    
    var studentRole: String {
        Role.Student.caseName
    }
    
    var teacherRole: String {
        Role.Teacher.caseName
    }
    
    var hasAccount: String {
        "Already have an account?"
    }
    
    var formTransitionPrompt: String {
        "Log In!"
    }
    
    var sendTo: FormMode {
        .login
    }
}

enum RegisterFormError: Error {
    case invalidRoleID
}
