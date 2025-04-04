//
//  AlertItem.swift
//  TeachME
//
//  Created by TumbaDev on 27.03.25.
//

import Foundation

struct AlertAction {
    let title: String
    let action: () -> ()
}

extension AlertAction {
    static func defaultConfirmation(_ action: @escaping () -> Void = {}) -> Self {
        self.init(title: "Ok", action: action)
    }
    
    static func defaultCancelation(_ action: @escaping () -> Void = {}) -> Self {
        self.init(title: "Cancel", action: action)
    }
}

struct AlertItem: Identifiable {
    let id: UUID = UUID()
    let message: String
    let primaryAction: AlertAction
    let secondaryAction: AlertAction?
}

extension AlertItem {
    init(
        alertType: AlertType,
        primaryAction: AlertAction = AlertAction(title: "Ok", action: {}),
        secondaryAction: AlertAction? = nil
    ) {
        let message: String
        switch alertType {
        case .firstName:
            message = "You first name was not updated correctly!\nPlease try again!"
        case .lastName:
            message = "You last name was not updated correctly!\nPlease try again!"
        case .email:
            message = "Your email was not updated correctly!\nPlease try again!"
        case .lessonsLoading:
            message = "Couldn't load lessons!\nPlease try again."
        case .lessonLoading:
            message = "Couldn't load this lesson!\nPlease try again."
        case .action(let action):
            message = "Couldn't \(action) this lesson from your list."
        case .saved(let teacherName):
            message = "Lesson with \(teacherName) saved successfully!"
        case .phone(let userName):
            message = "\(userName) has not provided a phone number!\nConsider sending an email."
        case .error:
            message = "Something went wrong!\nPlease try again in a moment!"
        }
        
        self.init(
            message: message,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )
    }
}
