//
//  TokenSetter.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

protocol TokenSetter {
    var key: String { get }
    var keychainStore: KeychainStore { get }
    var encoder: JSONEncoder { get }
    
    func setToken(token: TokenResponse) throws
}
