//
//  Endpoints.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

struct Endpoints {
    // MARK: ngrok need a new baseURL at the start of every gateway run
    static let baseURL: String = "https://842c-2a01-5a8-447-ab44-c5b1-cff0-85e8-9489.ngrok-free.app/"
    static let authURL: String = "\(baseURL)teach-me/"
    static let lessonTypesURL: String = "\(authURL)lesson-types/"
    static let rolesURL: String = "\(authURL)roles/"
    static let fetchAllRolesURL: String = "\(baseURL)roles"
    static let lessonsURL: String = "\(authURL)lessons/"
    static let usersURL: String = "\(authURL)users/"
}
