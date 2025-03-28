//
//  AuthMapper.swift
//  TeachME
//
//  Created by TumbaDev on 28.03.25.
//

import Foundation

struct AuthMapper {
    func credentialBodyModelToDTO(_ model: UserCredentialsBodyModel) -> UserCredentialsBodyDTO {
        UserCredentialsBodyDTO(email: model.email, password: model.password)
    }
    
    func registerBodyModelToDTO(_ model: UserRegisterBodyModel) -> UserRegisterBodyDTO {
        UserRegisterBodyDTO(
            email: model.email,
            password: model.password,
            firstName: model.firstName,
            lastName: model.lastName,
            roleId: model.roleId
        )
    }
}
