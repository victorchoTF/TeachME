//
//  EmailValidatedField.swift
//  TeachME
//
//  Created by TumbaDev on 27.03.25.
//

import SwiftUI

struct EmailValidatedField: View {
    @Binding var email: String
    @Binding var hasTriedInvalidEmail: Bool
    
    let placeholder: String
    let theme: Theme
    
    let tapGesture: () -> ()
    
    var body: some View {
        TextField(placeholder, text: $email)
            .keyboardType(.emailAddress)
            .styledTextField(theme: theme)
            .overlay(invalidEmailOverlay)
            .tint(hasTriedInvalidEmail ? theme.colors.error : nil)
            .onTapGesture {
                tapGesture()
            }
    }
    
    var invalidEmailOverlay: some View {
        hasTriedInvalidEmail ?
            RoundedRectangle(cornerRadius: theme.radiuses.medium)
                .stroke(theme.colors.error, lineWidth: 1)
        : nil
    }
}
