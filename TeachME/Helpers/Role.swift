//
//  Role.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

enum Role: String, CaseIterable {
    case student
    case teacher
    
    func toRoleModel(roles: Roles) -> RoleModel {
        switch self {
        case .student: roles.student
        case .teacher: roles.teacher
        }
    }
}

struct Roles {
    let student: RoleModel
    let teacher: RoleModel
    
    func toRole(roleModel: RoleModel) -> Role {
        if roleModel.id == teacher.id {
            return .teacher
        }
        
        return .student
    }
}

class RoleProvider {
    enum RoleLoaderError: Error {
        case studentNotFound
        case teacherNotFound
        case rolesNotInitialized
    }
    
    private let repository: RoleRepository
    private var roles: Roles? = nil
    
    init(repository: RoleRepository) {
        self.repository = repository
        
        Task {
            roles = try await loadRoles()
        }
    }
    
    func getRoles() throws -> Roles {
        guard let roles = roles else {
            throw RoleLoaderError.rolesNotInitialized
        }
        
        return roles
    }
}

private extension RoleProvider {
    func loadRoles() async throws -> Roles {
        let roles = try await repository.getAll()
        
        var student: RoleModel?
        var teacher: RoleModel?
        
        for role in roles {
            if role.title == "Student" {
                student = role
                continue
            }
            
            if role.title == "Teacher"{
                teacher = role
            }
        }
        
        guard let student = student else {
            throw RoleLoaderError.studentNotFound
        }
        
        guard let teacher = teacher else {
            throw RoleLoaderError.teacherNotFound
        }
        
        return Roles(student: student, teacher: teacher)
    }
}
