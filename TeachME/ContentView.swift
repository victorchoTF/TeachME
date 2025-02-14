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
    
    init() {
        self.theme = PrimaryTheme()
        self._tabRouter = StateObject(wrappedValue: TabRouter(theme: PrimaryTheme()))
    }
    
    var body: some View {
        tabView
    }
}

private extension ContentView {
    var tabView: some View {
        TabView(selection: $tabRouter.selectedTab) {
            studentHomeScreen
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
    
    var studentHomeScreen: some View {
        RouterView(title: "Home", router: tabRouter.homeRouter)
    }
    
    var lessonScreen: some View {
        RouterView(title: "Lessons", router: tabRouter.lessonRouter)
    }
    
    var profileScreen: some View {
        RouterView(title: "Profile", router: tabRouter.profileRouter)
    }
}
