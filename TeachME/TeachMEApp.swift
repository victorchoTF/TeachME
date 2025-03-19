//
//  TeachMEApp.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

@main
struct TeachMEApp: App {
    let dependencies: AppDependencies = AppDependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                theme: dependencies.theme,
                authRouter: dependencies.authRouter,
                tabRouter: dependencies.tabRouter
            )
        }
    }
}
