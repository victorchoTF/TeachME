//
//  AuthDataSource.swift
//  TeachME
//
//  Created by TumbaDev on 9.03.25.
//

import Foundation

final class AuthDataSource {
    let client: HTTPClient
    let baseURL: String
    
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    
    init(client: HTTPClient, baseURL: String, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.client = client
        self.baseURL = baseURL
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func login(user: UserCredentialsBodyDTO) async throws -> TokenResponse {
        let jsonData: Data
        do {
           jsonData = try encoder.encode(user)
        } catch {
           throw DataSourceError.encodingError("User of \(user) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "user-login")
            .setMethod(.post)
            .setHeaders(["application/json": "Content-Type"])
            .setBody(jsonData)
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
        let jsonData: Data
        do {
           jsonData = try encoder.encode(user)
        } catch {
           throw DataSourceError.encodingError("User of \(user) could not be encoded!")
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "user-register")
            .setMethod(.post)
            .setHeaders(["application/json": "Content-Type"])
            .setBody(jsonData)
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
        let jsonData: Data
        do {
           jsonData = try encoder.encode(tokenRequest)
        } catch {
            throw DataSourceError.encodingError(
                "RefreshTokenRequest of \(tokenRequest) could not be encoded!"
            )
        }
        
        guard let request = try URLRequestBuilder(baseURL: baseURL, path: "refresh-token")
            .setMethod(.post)
            .setHeaders(["application/json": "Content-Type"])
            .setBody(jsonData)
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
