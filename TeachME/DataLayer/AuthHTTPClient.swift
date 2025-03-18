//
//  AuthHTTPClient.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

class AuthHTTPClient: HTTPClient {
    private let tokenProvider: TokenProvider
    private let httpClient: HTTPClient
    
    init(tokenProvider: TokenProvider, httpClient: HTTPClient) {
        self.tokenProvider = tokenProvider
        self.httpClient = httpClient
    }
    
    func request(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        var signedRequest = request
        
        let token = try tokenProvider.token()
        signedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
        let response = try await httpClient.request(signedRequest)
        
        return response
    }
}
