//
//  LoginForm.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import SwiftUI

struct LoginForm: View {
    @StateObject var viewModel: LoginFormViewModel
    let toRegister: () -> ()
    
    var body: some View {
        VStack {
            FormTitle(title: viewModel.formTitle, theme: viewModel.theme)
            
            Form {
                accountDetails
                
                SubmitButton(text: viewModel.formType, theme: viewModel.theme)
                
                SwitchFormText(
                    text: viewModel.noAccount,
                    buttonLabel: viewModel.formTransitionPrompt,
                    theme: viewModel.theme,
                    switchAction: toRegister
                )
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .foregroundStyle(viewModel.theme.colors.dark)
        }
    }
}

private extension LoginForm {
    var accountDetails: some View {
        Section {
            TextField(viewModel.emailPlaceholder, text: $viewModel.email)
                .styledTextField(theme: viewModel.theme)
            TextField(viewModel.passwordPlaceholder, text: $viewModel.password)
                .styledTextField(theme: viewModel.theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(viewModel.theme.fonts.system14)
    }
}
