//
//  LoginForm.swift
//  TeachME
//
//  Created by TumbaDev on 21.01.25.
//

import SwiftUI

struct LoginForm: View {
    @StateObject var viewModel: LoginFormViewModel
    
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
        Section {
            TextField(viewModel.email, text: $viewModel.registerFields.email)
                .styledTextField()
            TextField(viewModel.password, text: $viewModel.registerFields.password)
                .styledTextField()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(.system(size: FontConstants.size14))
    }
}

#Preview {
    LoginForm(
        viewModel: RegisterFormViewModel(
            registerFields: RegisterFields()
        )
    )
}

