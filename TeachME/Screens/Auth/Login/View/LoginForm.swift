//
//  LoginForm.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import SwiftUI

struct LoginForm: View {
    @ObservedObject var viewModel: LoginFormViewModel
    let toRegister: @MainActor () -> ()
    
    let theme: Theme
    
    var body: some View {
        VStack {
            FormTitle(title: viewModel.formTitle, theme: theme)
            
            Form {
                accountDetails
                
                SubmitButton(text: viewModel.formType, theme: theme) {
                    viewModel.loginUser()
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
            EmailValidatedField(
                email: $viewModel.email,
                hasTriedInvalidEmail: $viewModel.hasTriedInvalidEmail,
                placeholder: viewModel.emailPlaceholder,
                theme: theme
            ) {
                viewModel.resetEmailError()
            }
            
            SecureField(viewModel.passwordPlaceholder, text: $viewModel.password)
                .styledTextField(theme: theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
}
