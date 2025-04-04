//
//  AlertModifier.swift
//  TeachME
//
//  Created by TumbaDev on 4.04.25.
//

import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var alertItem: AlertItem?
    
    func body(content: Content) -> some View {
        content
            .alert(item: $alertItem) { alertItem in
                if let secondaryAction = alertItem.secondaryAction {
                    Alert(
                        title: Text(alertItem.message),
                        primaryButton: .default(
                            Text(alertItem.primaryAction.title),
                            action: alertItem.primaryAction.action
                        ),
                        secondaryButton: .destructive(
                            Text(secondaryAction.title),
                            action: secondaryAction.action
                        )
                    )
                } else {
                    Alert(
                        title: Text(alertItem.message),
                        dismissButton: .default(
                            Text(alertItem.primaryAction.title),
                            action: alertItem.primaryAction.action
                        )
                    )
                }
            }
    }
}

extension View {
    func alert(_ item: Binding<AlertItem?>) -> some View {
        return modifier(AlertModifier(alertItem: item))
    }
}
