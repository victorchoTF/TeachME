//
//  LoginForm.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import SwiftUI

struct LoginForm: View {
    @ObservedObject var viewModel: LoginFormViewModel
    let toRegister: () -> ()
    
    let theme: Theme
    
    var body: some View {
        VStack {
            FormTitle(title: viewModel.formTitle, theme: theme)
            
            Form {
                accountDetails
                
                SubmitButton(text: viewModel.formType, theme: theme) {
                    Task {
                        let _ = try await viewModel.loginUser()
                    }
                }
                
                SwitchFormText(
                    text: viewModel.noAccount,
                    buttonLabel: viewModel.formTransitionPrompt,
                    theme: theme,
                    switchAction: toRegister
                )
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .foregroundStyle(theme.colors.text)
        }
    }
}

private extension LoginForm {
    var accountDetails: some View {
        Section {
            TextField(viewModel.emailPlaceholder, text: $viewModel.email)
                .styledTextField(theme: theme)
            TextField(viewModel.passwordPlaceholder, text: $viewModel.password)
                .styledTextField(theme: theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
}
