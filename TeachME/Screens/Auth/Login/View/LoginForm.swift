//
//  LoginForm.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import SwiftUI

struct LoginForm: View {
    enum Field: Hashable {
        case email
        case password
    }
    
    @ObservedObject var viewModel: LoginFormViewModel
    @FocusState private var focusedField: Field?
    let toRegister: @MainActor () -> ()
    
    let theme: Theme
    
    var body: some View {
        VStack {
            FormTitle(title: viewModel.formTitle, theme: theme)
            
            Form {
                accountDetails
                
                SubmitButton(text: viewModel.formType, theme: theme) {
                    viewModel.loginUser()
                    focusedField = nil
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
        .alert($viewModel.alertItem)
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
            .focused($focusedField, equals: .email)
            
            PasswordField(
                password: $viewModel.password,
                isSecure: $viewModel.isPasswordFieldSecure,
                placeholder: viewModel.passwordPlaceholder,
                theme: theme
            )
            .focused($focusedField, equals: .password)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
}
