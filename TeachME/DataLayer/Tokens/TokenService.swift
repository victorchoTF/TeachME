//
//  TokenService.swift
//  TeachME
//
//  Created by TumbaDev on 16.03.25.
//

import Foundation

final class TokenService: TokenSetter, TokenProvider {
    private let key: String
    private let keychainStore: KeychainStore
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(key: String, keychainStore: KeychainStore, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.key = key
        self.keychainStore = keychainStore
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func setToken(token: TokenResponse) throws {
        let tokenData = try encoder.encode(token)
        
        try keychainStore.addItem(key: key, item: tokenData)
    }
    
    func token() throws -> TokenResponse {
        let data = try keychainStore.getItem(key: key)
        
        let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
        
        return tokenResponse
    }
}
