//
//  SwiftUIView.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct LoginRegisterScreen: View {
    @StateObject var viewModel: LoginRegisterScreenViewModel
    
    var body: some View {
        VStack(spacing: SpacingConstants.spacing30) {
            HStack {
                Image("NamedLogo")
                    .padding(.bottom, SpacingConstants.spacing10)
            }
            .frame(maxWidth: .infinity)
            .background(ColorPalette.green)
            
            Group {
                switch viewModel.mode {
                case .login:
                    LoginForm(
                        viewModel: viewModel.loginFormViewModel,
                        formMode: $viewModel.mode
                    )
                    .transition(.move(edge: .leading))
                case .register:
                    RegisterForm(
                        viewModel: viewModel.registerFormsViewModel,
                        formMode: $viewModel.mode
                    )
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.mode)


        }
        .background(ColorPalette.mainBlue)
    }
}
