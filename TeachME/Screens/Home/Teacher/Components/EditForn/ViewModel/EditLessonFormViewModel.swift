//
//  File.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation

final class EditLessonFormViewModel: ObservableObject {
    @Published var lessonType = "Math"
    @Published var subtitle = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
        
    let lessonTypes = ["Maths", "Science", "History", "Art", "Other"]
    
    let lesson: LessonItem
    let onSubmit: () -> ()
    
    init(lesson: LessonItem, onSubmit: @escaping () -> ()) {
        self.lesson = lesson
        self.onSubmit = onSubmit
        
        // TODO: Load data for fields from db by id
        self.lessonType = lesson.lessonType
        self.subtitle = lesson.subtitle
    }
    
    func lessonFromForm() -> LessonItem {
        LessonItem(
            id: UUID(),
            lessonType: lessonType,
            subtitle: subtitle,
            startDate: formatDate(startDate),
            endDate: formatDate(endDate),
            teacherProfilePicture: lesson.teacherProfilePicture,
            teacherName: lesson.teacherName
        )
    }
    
    var formTitle: String {
        "Edit a lesson"
    }
    
    var pickerLabel: String {
        "Lesson Type"
    }
    
    var lessonDetailSectionTitle: String {
        "Lesson Details"
    }
    
    var lessonSubtitlePlaceholder: String {
        "Lesson Subtitle"
    }
    
    var scheduleSectionTitle: String {
        "Schedule"
    }
    
    var startDateLabel: String {
        "Start Date"
    }
    
    var endDateLabel: String {
        "End Date"
    }
    
    var buttonText: String {
        "Edit"
    }
}

private extension EditLessonFormViewModel {
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma dd.MM.yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }

}
