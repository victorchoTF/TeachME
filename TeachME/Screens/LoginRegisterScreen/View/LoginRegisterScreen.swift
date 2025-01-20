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
        VStack {
            RegisterForm(
                viewModel: viewModel.registerFormsViewModel
            )
        }
        .background(ColorPalette.mainBlue)
    }
}
