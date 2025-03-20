//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct AppView: View {
    let theme: Theme
    @StateObject var viewModel: AppViewModel
    
    init(theme: Theme, viewModel: AppViewModel) {
        self.theme = theme
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        currentView
    }
}

private extension AppView {
    @ViewBuilder
    var currentView: some View {
        switch viewModel.state {
        case .idle(let user):
            IdleScreen(
                theme: theme,
                viewModel: viewModel.iddleScreenViewModel(user: user, theme: theme)
            )
        case .auth:
            AuthScreen(viewModel: viewModel.authScreenViewModel, theme: theme)
        case .loading:
            // TODO: Implement in another PR
            Text("Loading...")
        }
    }
}
