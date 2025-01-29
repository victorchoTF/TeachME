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
    }
    
    var studentHomeScreen: some View {
        LessonListScreen(
            viewModel: LessonListScreenViewModel(
                lessons: [
                    LessonItem(
                        id: UUID(),
                        lessonType: "Chemistry",
                        subtitle: "Learning the basics of evening equations",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Chemistry",
                        subtitle: "Learning the basics of evening equations",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Chemistry",
                        subtitle: "Learning the basics of evening equations",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Chemistry",
                        subtitle: "Learning the basics of evening equations",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Chemistry",
                        subtitle: "Learning the basics of evening equations",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    )
                ]
            ),
            theme: theme
        )
    }
    
    var lessonScreen: some View {
        LessonListScreen(
            viewModel: LessonListScreenViewModel(
                lessons: [
                    LessonItem(
                        id: UUID(),
                        lessonType: "Maths",
                        subtitle: "Statistics made simple",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Chemistry",
                        subtitle: "Learning the basics of evening equations",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Biology",
                        subtitle: "Cranial system; Anatomy",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "English",
                        subtitle: "Learning the tenses",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    ),
                    LessonItem(
                        id: UUID(),
                        lessonType: "Physics",
                        subtitle: "Motion and mechanics",
                        startDate: "Start: 10:00AM 14.03.2025",
                        endDate: "End: 11:40AM 14.03.2025",
                        teacherProfilePicture: Image(systemName: "person.crop.circle"),
                        teacherName: "George Demo"
                    )
                ]
            ),
            theme: theme
        )
    }
}

#Preview {
    ContentView()
}
