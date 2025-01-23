//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme = StartTheme(
        colors: Colors(),
        spacings: Spacings(),
        radiuses: Radiuses(),
        fonts: Fonts()
    )
    
    var body: some View {
        AuthScreen(
            viewModel: AuthScreenViewModel(
                loginFormViewModel: LoginFormViewModel(
                    theme: theme
                ),
                registerFormsViewModel: RegisterFormViewModel(
                    theme: theme
                ),
                theme: theme
            )
        )
    }
}

#Preview {
    ContentView()
}
