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
                    cancelButton
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    doneButton
                }
            }

            .navigationTitle(viewModel.formTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert($viewModel.alertItem)
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
    
    var cancelButton: some View {
        ActionButton(
            buttonContent: .text(
                Text(viewModel.cancelButtonText)
            )
        ) {
            viewModel.onCancel()
        }
        .foregroundStyle(theme.colors.accent)
    }
    
    var doneButton: some View {
        ActionButton(
            buttonContent: .text(
                Text(viewModel.doneButtonText)
            )
        ) {
            viewModel.onSubmit()
        }
        .foregroundStyle(theme.colors.accent)
    }
}
