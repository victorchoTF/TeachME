//
//  StyledTextField.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import Foundation
import SwiftUI

struct StyledTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .padding(SpacingConstants.spacing10)
            .background(
                RoundedRectangle(cornerRadius: RadiusConstants.radius8)
                    .fill(ColorPalette.light)
            )
            .foregroundColor(ColorPalette.dark)
            .overlay(
                RoundedRectangle(cornerRadius: RadiusConstants.radius8)
                    .stroke(ColorPalette.dark, lineWidth: 1)
            )
    }
}

extension View {
    func styledTextField() -> some View {
        modifier(StyledTextField())
    }
}
