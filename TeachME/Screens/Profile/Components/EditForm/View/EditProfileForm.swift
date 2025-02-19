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
    
    let bioFieldMinHeight: CGFloat = 5
    
    var body: some View {
        NavigationView {
            Form {
                editFields
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ActionButton(title: viewModel.cancelButtonText, theme: theme) {
                        viewModel.onCancel()
                    }
                    .foregroundStyle(theme.colors.accent)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ActionButton(title: viewModel.editButtonText, theme: theme) {
                        viewModel.onSubmit()
                    }
                    .foregroundStyle(theme.colors.accent)
                }
            }
            .navigationTitle(viewModel.formTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension EditProfileForm {
    var editFields: some View {
        VStack {
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
                .frame(minHeight: bioFieldMinHeight)
                .styledTextField(theme: theme, padding: theme.spacings.extraSmall)
            if viewModel.shouldShowBioPlaceholder {
                Text(viewModel.bioPlaceholder)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(theme.spacings.medium)
            }
        }
    }
}
