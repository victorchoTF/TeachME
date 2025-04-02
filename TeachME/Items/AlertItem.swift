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
    let alertType: AlertType
}

extension AlertItem {
    init(alertType: AlertType) {
        switch alertType {
        case .firstName:
            self.init(
                message: "You first name was not updated correctly!\nPlease try again!",
                alertType: alertType
            )
        case .lastName:
            self.init(
                message: "You last name was not updated correctly!\nPlease try again!",
                alertType: alertType
            )
        case .email:
            self.init(
                message: "Your email was not updated correctly!\nPlease try again!",
                alertType: alertType
            )
        case .lessonsLoading:
            self.init(
                message: "Couldn't load lessons!\nPlease try again.",
                alertType: alertType
            )
        case .lessonLoading:
            self.init(
                message: "Couldn't load this lesson!\nPlease try again.",
                alertType: alertType
            )
        case .action(let action):
            self.init(
                message: "Couldn't \(action) this lesson from your list.",
                alertType: alertType
            )
        case .saved(let teacherName):
            self.init(
                message: "Lesson with \(teacherName) saved successfully!",
                alertType: alertType
            )
        case .phone(let userName):
            self.init(
                message: "\(userName) has not provided a phone number!\nConsider sending an email.",
                alertType: alertType
            )
        case .error:
            self.init(
                message: "Something went wrong!\nPlease try again in a moment!",
                alertType: alertType
            )
        }
    }
}
