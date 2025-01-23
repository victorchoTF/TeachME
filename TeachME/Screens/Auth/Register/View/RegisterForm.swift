//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    @StateObject var viewModel: RegisterFormViewModel
    let toLogin: () -> ()
    
    var body: some View {
        VStack {
            FormTitle(title: viewModel.formTitle, theme: viewModel.theme)

            Form {
                accountDetails
                
                personalDetails
                
                roleDetails
                
                SubmitButton(text: viewModel.formType, theme: viewModel.theme)
                
                SwitchFormText(
                    text: viewModel.hasAccount,
                    clickableText: viewModel.formTransitionPrompt,
                    theme: viewModel.theme,
                    switchAction: toLogin
                )
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .foregroundStyle(viewModel.theme.colors.dark)
        }
    }
}

private extension RegisterForm {
    var accountDetails: some View {
        Section(viewModel.accountDetailsHeading) {
            TextField(viewModel.emailPlaceholder, text: $viewModel.email)
                .styledTextField(theme: viewModel.theme)
            TextField(viewModel.passwordPlacehoder, text: $viewModel.password)
                .styledTextField(theme: viewModel.theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(viewModel.theme.fonts.system14)
    }
    
    private var personalDetails: some View {
        Section(viewModel.personalDetailsHeading) {
            TextField(viewModel.namePlaceholder, text: $viewModel.firstName)
                .styledTextField(theme: viewModel.theme)
            TextField(viewModel.lastNamePlaceholder, text: $viewModel.lastName)
                .styledTextField(theme: viewModel.theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(viewModel.theme.fonts.system14)
    }
    
    private var roleDetails: some View {
        Section(viewModel.roleHeading) {
            Picker(viewModel.roleHeading, selection: $viewModel.roleType) {
                Text(viewModel.studentRole).tag(Role.student)
                Text(viewModel.teacherRole).tag(Role.teacher)
            }
            .tint(viewModel.theme.colors.green)
            .pickerStyle(.segmented)
        }
        .listRowBackground(Color.clear)
        .font(viewModel.theme.fonts.system14)
    }
}
