//
//  EmailValidator.swift
//  TeachME
//
//  Created by TumbaDev on 26.03.25.
//

import Foundation

struct EmailValidator {
    let patternProvider: PatternProvider
    
    func isValid(email: String) -> Bool {
        do {
            return try email.wholeMatch(of: patternProvider.getPattern()) != nil
        } catch {
            return false
        }
    }
}

class PatternProvider {
    enum PatternProviderError: Error {
        case notInitialized
    }
    
    private let pattern: Regex<String>?
    
    init() {
        do {
            pattern = try Regex(#"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#)
        } catch {
            pattern = nil
        }
    }
    
    func getPattern() throws -> Regex<String>{
        guard let pattern = pattern else {
            throw PatternProviderError.notInitialized
        }
        return pattern
    }
}
