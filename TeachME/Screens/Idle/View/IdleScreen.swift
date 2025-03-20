//
//  IdleScreen.swift
//  TeachME
//
//  Created by TumbaDev on 20.03.25.
//

import SwiftUI

struct IdleScreen: View {
    let theme: Theme
    @StateObject var viewModel: IdleScreenViewModel
    
    init(theme: Theme, viewModel: IdleScreenViewModel) {
        self.theme = theme
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        tabView
    }
}

private extension IdleScreen {
    var tabView: some View {
        TabView(selection: $viewModel.tabRouter.selectedTab) {
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
        RouterView(title: "Home", router: viewModel.tabRouter.homeRouter)
    }
    
    var lessonScreen: some View {
        RouterView(title: "Lessons", router: viewModel.tabRouter.lessonRouter)
    }
    
    var profileScreen: some View {
        RouterView(title: "Profile", router: viewModel.tabRouter.profileRouter)
    }
}
