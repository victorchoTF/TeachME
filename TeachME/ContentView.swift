//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme = PrimaryTheme()
    
    var body: some View {
        AuthScreen(
            viewModel: AuthScreenViewModel(
                loginFormViewModel: LoginFormViewModel(),
                registerFormsViewModel: RegisterFormViewModel()
            ),
            theme: theme
        )
    }
}

#Preview {
    ContentView()
}
