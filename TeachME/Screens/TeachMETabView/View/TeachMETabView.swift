//
//  IdleScreen.swift
//  TeachME
//
//  Created by TumbaDev on 20.03.25.
//

import SwiftUI

struct TeachMETabView: View {
    let theme: Theme
    @StateObject var tabRouter: TabRouter
    
    init(theme: Theme, tabRouter: TabRouter) {
        self.theme = theme
        self._tabRouter = StateObject(wrappedValue: tabRouter)
    }
    
    
    var body: some View {
        tabView
    }
}

private extension TeachMETabView {
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
