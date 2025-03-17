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
    private let roleRepository: RoleRepository
    private let userMapper: UserMapper
    
    let onSubmit: (UserItem) -> ()
    
    init(
        repository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        userMapper: UserMapper,
        onSubmit: @escaping (UserItem) -> ()
    ) {
        self.repository = repository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.userMapper = userMapper
        self.onSubmit = onSubmit
    }
    
    func registerUser() {
        Task {
            guard let role: RoleModel = try await roleRepository.getAll().first(where: {
                $0.title == self.roleType.rawValue
            }) else {
                return
            }
            
            let _ = try await repository.register(
                user: UserRegisterBodyModel(
                    email: email,
                    password: password,
                    firstName: firstName,
                    lastName: lastName,
                    roleId: role.id
                )
            )
            
            let userItem = try await self.userMapper.modelToItem(
                userRepository.getUserByEmail(email)
            )
            
            onSubmit(userItem)
        }
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
