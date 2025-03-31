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
    }
    
    private var roles: Roles
    
    init (roles: Roles) {
        self.roles = roles
    }
    
    static func create(repository: RoleRepository) -> RoleProvider {
        let placeholderRoles = Roles(
            student: RoleModel(
                id: UUID(),
                title: Role.student.rawValue.capitalized
            ),
            teacher: RoleModel(
                id: UUID(),
                title: Role.teacher.rawValue.capitalized
            )
        )
        
        let provider = RoleProvider(roles: placeholderRoles)

        Task {
            let loadedRoles = try await loadRoles(from: repository)
            
            provider.updateRoles(loadedRoles)
        }

        return provider
    }
    
    func getRoles() -> Roles {
        return roles
    }
}

private extension RoleProvider {
    static func loadRoles(from repository: RoleRepository) async throws -> Roles {
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
    
    func updateRoles(_ newRoles: Roles) {
        self.roles = newRoles
    }
}
