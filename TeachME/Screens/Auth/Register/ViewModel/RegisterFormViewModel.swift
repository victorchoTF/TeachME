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
    
    private let reposiotry: AuthRepository
    private let roleRepository: RoleRepository
    
    init(repository: AuthRepository, roleRepository: RoleRepository) {
        self.reposiotry = repository
        self.roleRepository = roleRepository
    }
    
    func registerUser() {
        Task {
            do {
                let role = try await roleRepository.getAll().filter {
                    $0.title == roleType.rawValue
                }[0]
                
                let _ = try await reposiotry.register(
                    user: UserRegisterBodyModel(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        roleId: role.id
                    )
                )
            } catch {
                print("Error occured")
            }
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
    
    var sendTo: FormMode {
        .login
    }
}
