//
//  PasswordField.swift
//  TeachME
//
//  Created by TumbaDev on 6.04.25.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @Binding var isSecure: Bool
    let placeholder: String
    let theme: Theme

    var body: some View {
        HStack {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $password)
                        .styledTextField(theme: theme)
                } else {
                    TextField(placeholder, text: $password)
                        .styledTextField(theme: theme)
                }
            }
            
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(theme.colors.text.opacity(0.8))
            }
        }
    }
}
