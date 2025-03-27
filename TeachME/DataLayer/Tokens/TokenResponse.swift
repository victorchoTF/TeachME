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

struct AccessTokenPayload: Decodable {
    enum CodingKeys: String, CodingKey {
        case userId = "subject"
        case roleId
        case expiration
    }
    
    let userId: UUID
    let roleId: UUID
    let expiration: TimeInterval
}
