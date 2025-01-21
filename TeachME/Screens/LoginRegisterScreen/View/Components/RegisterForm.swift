//
//  Form.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct RegisterForm: View {
    @StateObject var viewModel: RegisterFormViewModel
    @Binding var formMode: FormMode
    
    var body: some View {
        VStack {
            Text(viewModel.formTitle)
                .fontWeight(.bold)
                .font(.system(size: FontConstants.size20))
                .foregroundStyle(ColorPalette.dark)

            Form {
                accountDetails
                
                personalDetails
                
                roleDetails
                
                Button {
                    print("Registered")
                } label: {
                    Text(viewModel.formType)
                        .fontWeight(.bold)
                        .font(.system(size: FontConstants.size18))
                        .foregroundStyle(ColorPalette.light)
                }
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, SpacingConstants.spacing10)
                .background(ColorPalette.green)
                .cornerRadius(RadiusConstants.radius8)
                
                HStack {
                    Text(viewModel.hasAccount)
                        .foregroundStyle(ColorPalette.dark)
                    Button {
                        withAnimation {
                            formMode.toggle()
                        }
                    } label: {
                        Text(viewModel.formTransitionPrompt)
                            .bold()
                            .underline()
                            .foregroundStyle(ColorPalette.dark)
                    }
                }
                .listRowBackground(Color.clear)
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .foregroundStyle(ColorPalette.dark)
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
