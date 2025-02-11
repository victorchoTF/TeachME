//
//  EditProfileForm.swift
//  TeachME
//
//  Created by TumbaDev on 9.02.25.
//

import SwiftUI

struct EditProfileForm: View {
    @ObservedObject var viewModel: EditProfileFormViewModel
    let theme: Theme
    
    let bioFieldHeight: CGFloat = 100
    
    var body: some View {
        Form {
            FormTitle(title: viewModel.formTitle, theme: theme)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            editFields
            
            SubmitButton(text: viewModel.buttonText, theme: theme) {
                viewModel.onSubmit()
            }
        }
    }
}

private extension EditProfileForm {
    var editFields: some View {
        Section {
            TextField(viewModel.emailPlaceholder, text: $viewModel.email)
                .styledTextField(theme: theme)
            
            TextField(viewModel.namePlaceholder, text: $viewModel.firstName)
                .styledTextField(theme: theme)
            
            TextField(viewModel.lastNamePlaceholder, text: $viewModel.lastName)
                .styledTextField(theme: theme)
            
            TextField(viewModel.phoneNumberPlaceholder, text: $viewModel.phoneNumber)
                .styledTextField(theme: theme)
            
            bioField
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    var bioField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $viewModel.bio)
                .frame(minHeight: bioFieldHeight)
                .styledTextField(theme: theme, padding: theme.spacings.extraSmall)
            if viewModel.bio.isEmpty {
                Text(viewModel.bioPlaceholder)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(theme.spacings.medium)
            }
        }
    }
}
