//
//  TokenProvider.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

protocol TokenProvider {
    var key: String { get }
    var keychainStore: KeychainStore { get }
    var decoder: JSONDecoder { get }
    
    func token() throws -> TokenResponse
}
