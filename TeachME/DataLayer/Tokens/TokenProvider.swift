//
//  TokenProvider.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

class TokenProvider {
    private let key: String
    private let keychainStore: KeychainStore
    private let decoder: JSONDecoder
    
    init(key: String, keychainStore: KeychainStore, decoder: JSONDecoder) {
        self.key = key
        self.keychainStore = keychainStore
        self.decoder = decoder
    }
    
    func token() throws -> TokenResponse {
        let data = try keychainStore.getItem(key: key)
        
        let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
        
        return tokenResponse
    }
}
