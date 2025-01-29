//
//  SwiftUIView.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct AuthScreen: View {
    @StateObject var viewModel: AuthScreenViewModel
    
    let theme: Theme
    
    var body: some View {
        VStack(spacing: theme.spacings.large) {
            Header(theme: theme)
            
            Group {
                switch viewModel.mode {
                case .login:

                    LoginForm(
                        viewModel: viewModel.loginFormViewModel,
                        toRegister: viewModel.switchToRegister,
                        theme: theme
                    )
                    .transition(.move(edge: .leading))
                case .register:
                    RegisterForm(
                        viewModel: viewModel.registerFormsViewModel,
                        toLogin: viewModel.switchToLogin,
                        theme: theme
                    )
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.mode)
        }
        .background(theme.colors.primary)
    }
}
