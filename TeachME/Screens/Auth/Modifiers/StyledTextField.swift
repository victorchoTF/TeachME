//
//  StyledTextField.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation
import SwiftUI

struct StyledTextField: ViewModifier {
    let theme: Theme
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .padding(theme.spacings.medium)
            .background(
                RoundedRectangle(cornerRadius: theme.radiuses.medium)
                    .fill(theme.colors.secondary)
            )
            .foregroundColor(theme.colors.text)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radiuses.medium)
                    .stroke(theme.colors.text, lineWidth: 1)
            )
    }
}

extension View {
    func styledTextField(theme: Theme) -> some View {
        modifier(StyledTextField(theme: theme))
    }
}
