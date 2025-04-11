//
//  TokenDTO.swift
//  TeachME
//
//  Created by TumbaDev on 9.03.25.
//

import Foundation

struct TokenData: Codable {
    let token: String
    let expiresAt: TimeInterval
}

struct TokenResponse: Codable {
    let accessToken: TokenData
    let refreshToken: TokenData
}
