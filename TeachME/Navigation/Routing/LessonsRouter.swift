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
                subtitle: "Explore the fascinating world of chemistry in this engaging and interactive lesson! Dive into the fundamental concepts of atomic structure, chemical bonding, and the periodic table. Understand how elements interact to form compounds and discover the role of chemical reactions in everyday life. Learn about acids, bases, and pH, and conduct experiments to observe reactions firsthand. Explore states of matter, thermodynamics, and the principles of stoichiometry.",
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
        let viewModel = LessonListScreenViewModel(lessons: lessons) { [weak self] lesson in
            guard let self else { return }
            
            path.append(.lesson(LessonPickScreenViewModel(lesson: lesson), theme))
        }

        return LessonListScreen(viewModel: viewModel, theme: theme)
    }
}
