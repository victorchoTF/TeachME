//
//  AlertItem.swift
//  TeachME
//
//  Created by TumbaDev on 27.03.25.
//

import Foundation

struct AlertItem: Identifiable {
    let id: UUID = UUID()
    let message: String
}

extension AlertItem {
    init(alertType: AlertType) {
        switch alertType {
        case .firstName:
            self.init(message: "You first name was not updated correctly!\nPlease try again!")
        case .lastName:
            self.init(message: "You last name was not updated correctly!\nPlease try again!")
        case .email:
            self.init(message: "Your email was not updated correctly!\nPlease try again!")
        case .lessonsLoading:
            self.init(message: "Couldn't load lessons!\nPlease try again.")
        case .lessonLoading:
            self.init(message: "Couldn't load this lesson!\nPlease try again.")
        case .action(let action):
            self.init(message: "Couldn't \(action) this lesson from your list.")
        case .saved(let teacherName):
            self.init(message: "Lesson with \(teacherName) saved successfully!")
        }
    }
}
