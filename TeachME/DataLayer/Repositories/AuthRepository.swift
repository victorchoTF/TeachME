//
//  AuthRepository.swift
//  TeachME
//
//  Created by TumbaDev on 9.03.25.
//

import Foundation

final class AuthRepository {
    private let dataSource: AuthDataSource
    private let mapper: UserMapper
    
    init(dataSource: AuthDataSource, mapper: UserMapper) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func login(user: UserCredentialsBodyModel) async throws -> TokenResponse {
        let userData = mapper.credentialBodyModelToData(user)
        
        return try await dataSource.login(user: userData)
    }
    
    func register(user: UserRegisterBodyModel) async throws -> TokenResponse {
        let userData = mapper.registerBodyModelToData(user)
        
        return try await dataSource.register(user: userData)
    }
    
    func refreshToken(tokenRequest: RefreshTokenRequest) async throws -> TokenResponse {
        return try await dataSource.refreshToken(tokenRequest: tokenRequest)
    }
}
