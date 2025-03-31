//
//  AuthHTTPClient.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

final class AuthHTTPClient: HTTPClient {
    private let tokenProvider: TokenProvider
    private let tokenDecoder: TokenDecoder
    private let httpClient: HTTPClient
    
    private let authRepository: AuthRepository
    
    init(
        tokenProvider: TokenProvider,
        tokenDecoder: TokenDecoder,
        authRepository: AuthRepository,
        httpClient: HTTPClient
    ) {
        self.tokenProvider = tokenProvider
        self.tokenDecoder = tokenDecoder
        self.httpClient = httpClient
        self.authRepository = authRepository
    }
    
    func request(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        var signedRequest = request
        
        var tokenData = try tokenProvider.token()
        
        let accessPayload = try getAccessPayload(tokenData.accessToken.token)
        
        if !isAccessTokenValid(tokenData.accessToken) {
            tokenData = try await getNewTokens(
                payload: accessPayload,
                refreshToken: tokenData.refreshToken.token
            )
        }
        
        signedRequest.setValue(
            "Bearer \(tokenData.accessToken.token)",
            forHTTPHeaderField: "Authorization"
        )
        
        
        let response = try await httpClient.request(signedRequest)
        
        return response
    }
}

private extension AuthHTTPClient {
    func getAccessPayload(_ token: String) throws -> AccessTokenPayload {
        let payload: AccessTokenPayload = try tokenDecoder.decodePayload(token)
        
        return payload
    }
    
    func isAccessTokenValid(_ token: TokenData) -> Bool {
        return token.expiresAt > Date().timeIntervalSince1970
    }
    
    func getNewTokens(
        payload: AccessTokenPayload,
        refreshToken: String
    ) async throws -> TokenResponse {
        let tokenResponse = try await authRepository.refreshToken(
            tokenRequest: RefreshTokenRequest(
                userId: payload.userId,
                roleId: payload.roleId,
                refreshToken: refreshToken
            )
        )
        
        return tokenResponse
    }
}
