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
    @Published var roleType: Role = .student
    @Published var roles: [Role] = []
    
    private var roleModels: [RoleModel] = [] {
        didSet {
            do {
                roles =  try roleModels.map { try roleMapper.modelToItem($0) }
            } catch {
                print("Throw, alert")
            }
        }
    }
    
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    private let roleRepository: RoleRepository
    private let userMapper: UserMapper
    private let roleMapper: RoleMapper
    
    let onSubmit: (UserItem) -> ()
    
    init(
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        userMapper: UserMapper,
        roleMapper: RoleMapper,
        onSubmit: @escaping (UserItem) -> ()
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.userMapper = userMapper
        self.roleMapper = roleMapper
        self.onSubmit = onSubmit
    }
    
    func loadRoles() async {
        do {
            roleModels = try await roleRepository.getAll()
        } catch {
            print("Alert!")
        }
    }
    
    func registerUser() {
        guard let roleId = roleModels.first(where: { $0.title == roleType.rawValue })?.id else { return
        }
        
        Task {
            let _ = try await authRepository.register(
                user: UserRegisterBodyModel(
                    email: email,
                    password: password,
                    firstName: firstName,
                    lastName: lastName,
                    roleId: roleId
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
