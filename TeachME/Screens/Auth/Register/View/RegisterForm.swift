//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    @ObservedObject var viewModel: RegisterFormViewModel
    let toLogin: () -> ()
    
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
    }
}

private extension RegisterForm {
    var accountDetails: some View {
        Section(viewModel.accountDetailsHeading) {
            TextField(viewModel.emailPlaceholder, text: $viewModel.email)
                .keyboardType(.emailAddress)
                .styledTextField(theme: theme)
                .overlay(invalidEmailOverlay)
                .tint(viewModel.hasTriedInvalidEmail ? theme.colors.error : nil)
                .onTapGesture {
                    viewModel.resetEmailError()
                }
            SecureField(viewModel.passwordPlacehoder, text: $viewModel.password)
                .styledTextField(theme: theme)
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
                Text(viewModel.studentRole).tag(Role.student)
                Text(viewModel.teacherRole).tag(Role.teacher)
            }
            .tint(theme.colors.accent)
            .pickerStyle(.segmented)
        }
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    var invalidEmailOverlay: some View {
        viewModel.hasTriedInvalidEmail ?
            RoundedRectangle(cornerRadius: theme.radiuses.medium)
                .stroke(theme.colors.error, lineWidth: 1)
        : nil
    }
}
