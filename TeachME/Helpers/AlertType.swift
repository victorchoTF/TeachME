//
//  AlertType.swift
//  TeachME
//
//  Created by TumbaDev on 28.03.25.
//

import Foundation

enum AlertType {
    case firstName
    case lastName
    case email
    case lessonsLoading
    case lessonLoading
    case action(String)
    case saved(String)
}
