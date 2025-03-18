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
    private let tokenSetter: TokenSetter
    
    init(dataSource: AuthDataSource, mapper: UserMapper, tokenSetter: TokenSetter) {
        self.dataSource = dataSource
        self.mapper = mapper
        self.tokenSetter = tokenSetter
    }
    
    func login(user: UserCredentialsBodyModel) async throws -> TokenResponse {
        let userData = mapper.credentialBodyModelToDTO(user)
        let token = try await dataSource.login(user: userData)
        
        try tokenSetter.setToken(token: token)
        
        return token
    }
    
    func register(user: UserRegisterBodyModel) async throws -> TokenResponse {
        let userData = mapper.registerBodyModelToDTO(user)
        let token = try await dataSource.register(user: userData)
        
        try tokenSetter.setToken(token: token)
        
        return token
    }
    
    func refreshToken(tokenRequest: RefreshTokenRequest) async throws -> TokenResponse {
        let token = try await dataSource.refreshToken(tokenRequest: tokenRequest)
        
        try tokenSetter.setToken(token: token)
        
        return token
    }
}
