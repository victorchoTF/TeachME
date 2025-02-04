//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme = PrimaryTheme()
    
    @StateObject var tabRouter = TabRouter()
    
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
            
            VStack {
                Text("To be made...")
            }
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
        LessonNavigationView(title: "Home", router: tabRouter.homeRouter)
    }
    
    var lessonScreen: some View {
        LessonNavigationView(title: "Lessons", router: tabRouter.lessonRouter)
    }
}
