//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme = PrimaryTheme()
    
    var body: some View {
        tabView
    }
}

private extension ContentView {
    var tabView: some View {
        TabView {
            studentHomeScreen
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            lessonScreen
                .tabItem {
                    Label("Lessons", systemImage: "graduationcap.fill")
                }
            
            VStack {
                Text("To be made...")
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .tint(theme.colors.accent)
        .background(theme.colors.primary)
        .foregroundStyle(theme.colors.text)
    }
    
    var studentHomeScreen: some View {
        LessonNavigationView(title: "Home", router: LessonsRouter())
    }
    
    var lessonScreen: some View {
        LessonNavigationView(title: "Lessons", router: LessonsRouter())
    }
}
