//
//  EmailDefaults.swift
//  TeachME
//
//  Created by TumbaDev on 1.04.25.
//

import Foundation

final class EmailDefaults {
    enum EmailDefaultsError: Error {
        case notFound(String)
    }
    
    private let userDefaults: UserDefaults
    private let key: String
    
    init(userDefaults: UserDefaults, key: String) {
        self.userDefaults = userDefaults
        self.key = key
    }
    
    func setEmail(_ email: String) {
        userDefaults.set(email, forKey: key)
    }
    
    func getEmail() throws -> String {
        guard let email = userDefaults.string(forKey: key) else {
            throw EmailDefaultsError.notFound("Email on key: \(key) not found!")
        }
        
        return email
    }
    
    func removeEmail() {
        userDefaults.removeObject(forKey: key)
    }
}
