//
//  LoginForm.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import SwiftUI

struct LoginForm: View {
    @StateObject var viewModel: LoginFormViewModel
    @Binding var formMode: FormMode
    
    var body: some View {
        VStack {
            Text(viewModel.formTitle)
                .fontWeight(.bold)
                .font(.system(size: FontConstants.size20))
                .foregroundStyle(ColorPalette.dark)
            
            Form {
                accountDetails
                
                Button {
                    print("Logged in")
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
                    Text(viewModel.noAccount)
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
            .scrollDisabled(true)
            .foregroundStyle(ColorPalette.dark)
        }
    }
    
    private var accountDetails: some View {
        Section {
            TextField(viewModel.email, text: $viewModel.loginFields.email)
                .styledTextField()
            TextField(viewModel.password, text: $viewModel.loginFields.password)
                .styledTextField()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(.system(size: FontConstants.size14))
    }
}

