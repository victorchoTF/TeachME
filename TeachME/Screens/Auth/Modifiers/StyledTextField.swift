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
            .padding(theme.spacings.spacing10)
            .background(
                RoundedRectangle(cornerRadius: theme.radiuses.radius8)
                    .fill(theme.colors.light)
            )
            .foregroundColor(theme.colors.dark)
            .overlay(
                RoundedRectangle(cornerRadius: theme.radiuses.radius8)
                    .stroke(theme.colors.dark, lineWidth: 1)
            )
    }
}

extension View {
    func styledTextField(theme: Theme) -> some View {
        modifier(StyledTextField(theme: theme))
    }
}
