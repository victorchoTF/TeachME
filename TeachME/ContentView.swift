//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme: Theme
    let authRouter: AuthRouter

    @StateObject var tabRouterFacade: TabRouterFacade
    
    init(theme: Theme, authRouter: AuthRouter, tabRouterFacade: TabRouterFacade) {
        self.theme = theme
        self.authRouter = authRouter
        self._tabRouterFacade = StateObject(
            wrappedValue: tabRouterFacade
        )
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
        TabView(selection: $tabRouterFacade.selectedTab) {
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
        RouterView(title: "Home", router: tabRouterFacade.homeRouter as! HomeRouter)
    }
    
    var lessonScreen: some View {
        RouterView(title: "Lessons", router: tabRouterFacade.lessonRouter as! HomeRouter)
    }
    
    var profileScreen: some View {
        RouterView(title: "Profile", router: tabRouterFacade.profileRouter as! ProfileRouter)
    }
}
