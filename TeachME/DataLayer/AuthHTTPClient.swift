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
        
        let tokenData = try tokenProvider.token()
        
        signedRequest.setValue(
            "Bearer \(tokenData.accessToken.token)",
            forHTTPHeaderField: "Authorization"
        )
        
        print("REQUEST: ")
        print(signedRequest.url ?? "No url")
        print(signedRequest.httpMethod ?? "No method")
        print(String(data: signedRequest.httpBody ?? Data(), encoding: .utf8) ?? "No body")
        print(signedRequest.allHTTPHeaderFields ?? "No header fields")
            
        let response = try await httpClient.request(signedRequest)
        
        return response
    }
}
