//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    enum Field: Hashable {
        case email
        case password
        case firstName
        case lastName
        case role
    }
    
    @ObservedObject var viewModel: RegisterFormViewModel
    @FocusState private var focusedField: Field?
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
                    focusedField = nil
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
            .focused($focusedField, equals: .email)
            
            PasswordField(
                password: $viewModel.password,
                isSecure: $viewModel.isPasswordFieldSecure,
                placeholder: viewModel.passwordPlacehoder,
                theme: theme
            )
            .focused($focusedField, equals: .password)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    private var personalDetails: some View {
        Section(viewModel.personalDetailsHeading) {
            TextField(viewModel.namePlaceholder, text: $viewModel.firstName)
                .styledTextField(theme: theme)
                .focused($focusedField, equals: .firstName)
            TextField(viewModel.lastNamePlaceholder, text: $viewModel.lastName)
                .styledTextField(theme: theme)
                .focused($focusedField, equals: .lastName)
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
            .focused($focusedField, equals: .role)
        }
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
}
