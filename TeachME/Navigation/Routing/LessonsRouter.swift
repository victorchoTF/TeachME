//
//  LessonsRouter.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import Foundation
import SwiftUI

class LessonsRouter: ObservableObject {
    @Published var path = [Destination]()
    @Published var sheetRouter: IdentifiableRouter? = nil
    
    let lessons: [LessonItem]
    let theme: Theme
    
    init() {
        theme = PrimaryTheme()
        
        lessons = [
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
    }

    @MainActor
    var initialDestination: some View {
        let viewModel = LessonListScreenViewModel(
            lessons: lessons
        )

        return LessonListScreen(viewModel: viewModel, theme: theme)
    }
}
