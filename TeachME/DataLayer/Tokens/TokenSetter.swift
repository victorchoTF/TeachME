//
//  TokenSetter.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

class TokenSetter {
    private let key: String
    private let keychainStore: KeychainStore
    private let encoder: JSONEncoder
    
    init(key: String, keychainStore: KeychainStore, encoder: JSONEncoder) {
        self.key = key
        self.keychainStore = keychainStore
        self.encoder = encoder
    }
    
    func setToken(token: TokenResponse) throws {
        let tokenData = try encoder.encode(token)
        
        try keychainStore.addItem(key: key, item: tokenData)
    }
}
