//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme: Theme
    
    @StateObject var tabRouter: TabRouter
    @StateObject var authRouter: AuthRouter

    
    init(theme: Theme, authRouter: AuthRouter, tabRouter: TabRouter) {
        self.theme = theme
        self._authRouter = StateObject(wrappedValue: authRouter)
        self._tabRouter = StateObject(wrappedValue: tabRouter)
    }
    
    var body: some View {
        if authRouter.isLoggedIn {
            tabView
        } else {
            authScreen
        }
    }
}

private extension ContentView {
    var authScreen: some View {
        authRouter.initialDestination
    }
    
    var tabView: some View {
        TabView(selection: $tabRouter.selectedTab) {
            homeScreen
                .tag(Tab.home)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            lessonScreen
                .tag(Tab.lessons)
                .tabItem {
                    Label("Lessons", systemImage: "graduationcap.fill")
                }
            
            profileScreen
                .tag(Tab.profile)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(theme.colors.accent)
        .background(theme.colors.primary)
        .foregroundStyle(theme.colors.text)
    }
    
    var homeScreen: some View {
        RouterView(title: "Home", router: tabRouter.homeRouter)
    }
    
    var lessonScreen: some View {
        RouterView(title: "Lessons", router: tabRouter.lessonRouter)
    }
    
    var profileScreen: some View {
        RouterView(title: "Profile", router: tabRouter.profileRouter)
    }
}
