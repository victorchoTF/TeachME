//
//  SwiftUIView.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct AuthScreen: View {
    @StateObject var viewModel: AuthScreenViewModel
    
    var body: some View {
        VStack(spacing: viewModel.theme.spacings.spacing30) {
            HStack {
                Image("NamedLogo")
                    .padding(.bottom, viewModel.theme.spacings.spacing10)
            }
            .frame(maxWidth: .infinity)
            .background(viewModel.theme.colors.green)
            
            Group {
                switch viewModel.mode {
                case .login:

                    LoginForm(
                        viewModel: viewModel.loginFormViewModel,
                        toRegister: viewModel.switchToRegister
                    )
                    .transition(.move(edge: .leading))
                case .register:
                    RegisterForm(
                        viewModel: viewModel.registerFormsViewModel,
                        toLogin: viewModel.switchToLogin
                    )
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.mode)
        }
        .background(viewModel.theme.colors.mainBlue)
    }
}
