//
//  PasswordField.swift
//  TeachME
//
//  Created by TumbaDev on 6.04.25.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    let placeholder: String
    let theme: Theme
    
    @State private var isSecure: Bool = true

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
            .autocapitalization(.none)
            .disableAutocorrection(true)
            
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
    }
}
