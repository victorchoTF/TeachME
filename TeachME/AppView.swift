//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct AppView: View {
    let theme: Theme
    @StateObject var router: AppRouter
    
    init(theme: Theme, router: AppRouter) {
        self.theme = theme
        self._router = StateObject(wrappedValue: router)
    }
    
    var body: some View {
        router.initialDestination
            .task { await router.startAppState() }
    }
}
