//
//  RefreshTokenRequest.swift
//  TeachME
//
//  Created by TumbaDev on 9.03.25.
//

import Foundation

struct RefreshTokenRequest: Codable {
    let userId: UUID
    let roleId: UUID
    let refreshToken: String
}
