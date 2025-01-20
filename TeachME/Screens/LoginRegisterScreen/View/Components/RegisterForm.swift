//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    @StateObject var viewModel: RegisterFormViewModel
    
    var body: some View {
        Form {
            accountDetails
            
            personalDetails
            
            roleDetails
        }
        .scrollContentBackground(.hidden)
        .foregroundStyle(ColorPalette.dark)
    }
    
    private var accountDetails: some View {
        Section(viewModel.accountDetailsHeading) {
            TextField(viewModel.email, text: $viewModel.registerFields.email)
                .styledTextField()
            TextField(viewModel.password, text: $viewModel.registerFields.password)
                .styledTextField()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
    private var personalDetails: some View {
        Section(viewModel.personalDetailsHeading) {
            TextField(viewModel.name, text: $viewModel.registerFields.firstName)
                .styledTextField()
            TextField(viewModel.lastName, text: $viewModel.registerFields.lastName)
                .styledTextField()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
    
    private var roleDetails: some View {
        Section(viewModel.roleHeading) {
            Picker(viewModel.roleHeading, selection: $viewModel.registerFields.roleType) {
                Text(viewModel.studentRole).tag(Role.student)
                Text(viewModel.teacherRole).tag(Role.teacher)
            }
            .tint(ColorPalette.green)
            .pickerStyle(.segmented)
        }
        .listRowBackground(Color.clear)
    }
}

#Preview {
    RegisterForm(
        viewModel: RegisterFormViewModel(
            registerFields: RegisterFields()
        )
    )
}
