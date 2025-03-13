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
    let padding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: theme.radiuses.medium)
                    .fill(theme.colors.secondary)
            )
            .foregroundColor(theme.colors.text)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radiuses.medium)
                    .stroke(theme.colors.text, lineWidth: 1)
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

extension View {
    func styledTextField(theme: Theme, padding: CGFloat? = nil) -> some View {
        guard let padding = padding else {
            return modifier(StyledTextField(theme: theme, padding: theme.spacings.medium))
        }
        
        return modifier(StyledTextField(theme: theme, padding: padding))
    }
}
