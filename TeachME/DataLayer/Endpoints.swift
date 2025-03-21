//
//  Endpoints.swift
//  TeachME
//
//  Created by TumbaDev on 13.03.25.
//

import Foundation

struct Endpoints {
    static let baseURL: String = "http://127.0.0.1:8080/"
    static let authURL: String = "\(baseURL)teach-me/"
    static let lessonTypesURL: String = "\(authURL)lesson-types/"
    static let rolesURL: String = "\(authURL)roles/"
    static let lessonsURL: String = "\(authURL)lessons/"
    static let usersURL: String = "\(authURL)users/"
}
