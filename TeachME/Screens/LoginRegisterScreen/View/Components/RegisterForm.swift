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
        VStack {
            Text("Start your knoledge journey today!")
                .fontWeight(.bold)
                .font(.system(size: FontConstants.size20))
                .foregroundStyle(ColorPalette.dark)
            
            Form {
                accountDetails
                
                personalDetails
                
                roleDetails
                
                Button {
                    print("Hello")
                } label: {
                    Text("Register")
                        .fontWeight(.bold)
                        .font(.system(size: FontConstants.size18))
                        .foregroundStyle(ColorPalette.light)
                }
                .cornerRadius(RadiusConstants.radius8)
                .listRowBackground(ColorPalette.green)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, SpacingConstants.spacing4)
                
            }
            .scrollContentBackground(.hidden)
            .foregroundStyle(ColorPalette.dark)
            
            Text("Already have an account? Login")
        }
    }
    
    private var accountDetails: some View {
        Section(viewModel.accountDetailsHeading) {
            TextField(viewModel.email, text: $viewModel.registerFields.email)
                .styledTextField()
            TextField(viewModel.password, text: $viewModel.registerFields.password)
                .styledTextField()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(.system(size: FontConstants.size14))
    }
    
    private var personalDetails: some View {
        Section(viewModel.personalDetailsHeading) {
            TextField(viewModel.name, text: $viewModel.registerFields.firstName)
                .styledTextField()
            TextField(viewModel.lastName, text: $viewModel.registerFields.lastName)
                .styledTextField()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(.system(size: FontConstants.size14))
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
        .font(.system(size: FontConstants.size14))
    }
}

#Preview {
    RegisterForm(
        viewModel: RegisterFormViewModel(
            registerFields: RegisterFields()
        )
    )
}
