//
//  SwiftUIView.swift
//  TeachME
//
//  Created by TumbaDev on 20.01.25.
//

import SwiftUI

struct LoginRegisterScreen: View {
    let viewModel: LoginRegisterScreenViewModel
    
    var body: some View {
        VStack(spacing: SpacingConstants.spacing30) {
            HStack {
                Image("NamedLogo")
                    .padding(.bottom, SpacingConstants.spacing10)
            }
            .frame(maxWidth: .infinity)
            .background(ColorPalette.green)
            
            RegisterForm(
                viewModel: viewModel.registerFormsViewModel
            )
        }
        .background(ColorPalette.mainBlue)
    }
}
