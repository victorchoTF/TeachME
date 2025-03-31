//
//  Role.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation

enum Role: String, CaseIterable, Identifiable {
    case student = "Student"
    case teacher = "Teacher"
    
    var id: String {
        self.rawValue
    }
}
