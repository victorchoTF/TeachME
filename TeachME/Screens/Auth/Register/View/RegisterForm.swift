//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    @ObservedObject var viewModel: RegisterFormViewModel
    let toLogin: @MainActor () -> ()
    
    let theme: Theme
    
    var body: some View {
        VStack {
            FormTitle(title: viewModel.formTitle, theme: theme)

            Form {
                accountDetails
                
                personalDetails
                
                roleDetails
                
                SubmitButton(text: viewModel.formType, theme: theme) {
                    viewModel.registerUser()
                }
                
                SwitchFormText(
                    text: viewModel.hasAccount,
                    buttonLabel: viewModel.formTransitionPrompt,
                    theme: theme,
                    switchAction: toLogin
                )
            }
            .scrollContentBackground(.hidden)
            .foregroundStyle(theme.colors.text)
        }
        .alert($viewModel.alertItem)
        .task {
            await viewModel.loadRoles()
        }
    }
}

private extension RegisterForm {
    var accountDetails: some View {
        Section(viewModel.accountDetailsHeading) {
            EmailValidatedField(
                email: $viewModel.email,
                hasTriedInvalidEmail: $viewModel.hasTriedInvalidEmail,
                placeholder: viewModel.emailPlaceholder,
                theme: theme
            ) {
                viewModel.resetEmailError()
            }
            
            PasswordField(
                password: $viewModel.password,
                isSecure: $viewModel.isPasswordFieldSecure,
                placeholder: viewModel.passwordPlacehoder,
                theme: theme
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    private var personalDetails: some View {
        Section(viewModel.personalDetailsHeading) {
            TextField(viewModel.namePlaceholder, text: $viewModel.firstName)
                .styledTextField(theme: theme)
            TextField(viewModel.lastNamePlaceholder, text: $viewModel.lastName)
                .styledTextField(theme: theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    private var roleDetails: some View {
        Section(viewModel.roleHeading) {
            Picker(viewModel.roleHeading, selection: $viewModel.roleType) {
                ForEach(viewModel.roles) {
                    Text($0.rawValue).tag($0)
                }
            }
            .tint(theme.colors.accent)
            .pickerStyle(.segmented)
        }
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
}
