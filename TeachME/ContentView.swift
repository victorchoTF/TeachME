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
}

#Preview {
    ContentView()
}
