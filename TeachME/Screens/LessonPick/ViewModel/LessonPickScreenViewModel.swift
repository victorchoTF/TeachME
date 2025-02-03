//
//  LessonPickScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import Foundation
import SwiftUI // TODO: Remove after DataLoading is implemented

final class LessonPickScreenViewModel {
    let pickedLesson: LessonItem
    var teacher: UserItem = UserItem()
    var otherLessons: [LessonItem] = []
    
    init(lesson: LessonItem) {
        self.pickedLesson = lesson
        
        loadData()
    }
    
    // TODO: Should load real data in future
    func loadData() {
        teacher = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves"
        )
        
        otherLessons = [
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
    
    var moreAboutTitle: String {
        "More about the teacher"
    }
    
    var otherLessonsTitle: String {
        "Other lessons"
    }
    
    var pickLessonButtonText: String {
        "Save"
    }
}
