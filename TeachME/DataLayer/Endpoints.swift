//
//  Endpoints.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

struct Endpoints {
    static let baseURL: String = "https://8530-2a01-5a8-469-b79e-9547-5a2-e6ca-bffa.ngrok-free.app/"
    static let authURL: String = "\(baseURL)teach-me/"
    static let lessonTypesURL: String = "\(authURL)lesson-types/"
    static let rolesURL: String = "\(authURL)roles/"
    static let fetchAllRolesURL: String = "\(baseURL)roles"
    static let lessonsURL: String = "\(authURL)lessons/"
    static let usersURL: String = "\(authURL)users/"
}
