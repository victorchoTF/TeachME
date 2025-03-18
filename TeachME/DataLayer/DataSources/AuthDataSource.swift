//
//  AuthDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 9.03.25.
//

import Foundation

final class AuthDataSource {
    private let client: HTTPClient
    private let baseURL: String
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(client: HTTPClient, baseURL: String, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.baseURL = baseURL
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func login(user: UserCredentialsBodyDTO) async throws -> TokenResponse {
        let userCredentialsData: Data
        do {
           userCredentialsData = try encoder.encode(user)
        } catch {
           throw DataSourceError.encodingError("User of \(user) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "user-login")
            .setMethod(.post)
            .setBody(userCredentialsData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }

        let token: Data
        do {
            (token, _) = try await client.request(request)
        } catch {
            throw DataSourceError.postingError("User of \(user) could not login!")
        }
        
        let tokenResponse: TokenResponse
        do {
            tokenResponse = try decoder.decode(TokenResponse.self, from: token)
        } catch {
            throw DataSourceError.decodingError(
                "TokenResponse of \(token) could not be decoded!"
            )
        }
        
        return tokenResponse
    }
    
    func register(user: UserRegisterBodyDTO) async throws -> TokenResponse {
        let userRegisterBodyData: Data
        do {
           userRegisterBodyData = try encoder.encode(user)
        } catch {
           throw DataSourceError.encodingError("User of \(user) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "user-register")
            .setMethod(.post)
            .setBody(userRegisterBodyData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }

        let token: Data
        do {
            (token, _) = try await client.request(request)
        } catch {
           throw DataSourceError.postingError("User of \(user) could not login!")
        }
        
        let tokenResponse: TokenResponse
        do {
            tokenResponse = try decoder.decode(TokenResponse.self, from: token)
        } catch {
            throw DataSourceError.decodingError(
                "TokenResponse of \(token) could not be decoded!"
            )
        }
        
        return tokenResponse
    }
    
    func refreshToken(tokenRequest: RefreshTokenRequest) async throws -> TokenResponse {
        let refreshTokenRequestData: Data
        do {
           refreshTokenRequestData = try encoder.encode(tokenRequest)
        } catch {
            throw DataSourceError.encodingError(
                "RefreshTokenRequest of \(tokenRequest) could not be encoded!"
            )
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "refresh-token")
            .setMethod(.post)
            .setBody(refreshTokenRequestData)
            .build()
        else {
            throw DataSourceError.invalidURL("\(baseURL) not found")
        }

        let token: Data
        do {
            (token, _) = try await client.request(request)
        } catch {
            throw DataSourceError.postingError(
                "RefreshTokenRequest of \(tokenRequest) could not login!"
            )
        }
        
        let tokenResponse: TokenResponse
        do {
            tokenResponse = try decoder.decode(TokenResponse.self, from: token)
        } catch {
            throw DataSourceError.decodingError(
                "TokenResponse of \(token) could not be decoded!"
            )
        }
        
        return tokenResponse
    }
}
