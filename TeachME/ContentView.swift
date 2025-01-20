//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginRegisterScreen(
            viewModel: LoginRegisterScreenViewModel(
                registerFormsViewModel: RegisterFormViewModel(
                    registerFields: RegisterFields()
                )
            )
        )
    }
}

#Preview {
    ContentView()
}
