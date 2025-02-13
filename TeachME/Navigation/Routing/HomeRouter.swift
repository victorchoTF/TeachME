//
//  LessonsRouter.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import Foundation
import SwiftUI

class HomeRouter {
    @Published var path = [Destination]()
    
    let lessons: [LessonItem]
    let theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        
        lessons = [
            LessonItem(
                id: UUID(),
                lessonType: "Maths",
                subtitle: "In this math lesson, explore key concepts such as algebra, geometry, calculus, and probability. Learn how to solve equations, understand geometric shapes, analyze data, and apply mathematical theories to real-world problems. With step-by-step explanations and interactive exercises, enhance your problem-solving skills.",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "Chemistry",
                subtitle: "Explore the fascinating world of chemistry in this engaging and interactive lesson! Dive into the fundamental concepts of atomic structure, chemical bonding, and the periodic table. Understand how elements interact to form compounds and discover the role of chemical reactions in everyday life. Learn about acids, bases, and pH, and conduct experiments to observe reactions firsthand. Explore states of matter, thermodynamics, and the principles of stoichiometry.",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "Biology",
                subtitle: "Cranial system; Anatomy",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "English",
                subtitle: "Learning the tenses",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            ),
            LessonItem(
                id: UUID(),
                lessonType: "Physics",
                subtitle: "Motion and mechanics",
                startDate: "10:00AM 14.03.2025",
                endDate: "11:40AM 14.03.2025",
                teacherProfilePicture: Image(systemName: "person.crop.circle"),
                teacherName: "George Demo"
            )
        ]
    }
}

extension HomeRouter: Router {
    @MainActor
    var initialDestination: some View {
        let viewModel = LessonListScreenViewModel(lessons: lessons, router: self)

        return LessonListScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
