//
//  LessonFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation

final class LessonFormViewModel: ObservableObject, Identifiable {
    @Published var lessonType: String
    @Published var subtitle: String
    @Published var startDate: Date
    @Published var endDate: Date
    
    // TODO: Load from LessonTypes
    let lessonTypes = ["Maths", "Science", "History", "Art", "Other"]
    
    let lesson: LessonItem
    let formType: String
    
    private let updateLesson: (LessonItem) -> ()
    let onCancel: () -> ()
    
    init(
        lesson: LessonItem,
        formType: String,
        onCancel: @escaping() -> (),
        updateLesson: @escaping (LessonItem) -> ()
    ) {
        self.lesson = lesson
        self.onCancel = onCancel
        self.updateLesson = updateLesson
        self.formType = formType
        
        self.lessonType = lesson.lessonType
        self.subtitle = lesson.subtitle
        self.startDate = Date()
        self.endDate = Date()
    }

    func onSubmit() {
        let lesson = LessonItem(
            id: UUID(),
            lessonType: lessonType,
            subtitle: subtitle,
            startDate: formatDate(startDate),
            endDate: formatDate(endDate),
            teacherProfilePicture: lesson.teacherProfilePicture,
            teacherName: lesson.teacherName
        )
        
        updateLesson(lesson)
    }
    
    var formTitle: String {
        "\(formType) your lesson"
    }
    
    var pickerLabel: String {
        "Lesson Type"
    }
    
    var lessonSubtitlePlaceholder: String {
        "Lesson Subtitle"
    }
    
    var shouldShowSubtitlePlaceholder: Bool {
        subtitle.isEmpty
    }
    
    var startDateLabel: String {
        "Starts at"
    }
    
    var startDateHint: String {
        "Pick start date for your lesson"
    }
    
    var endDateHint: String {
        "Pick end date for your lesson"
    }
    
    var endDateLabel: String {
        "Ends at"
    }
    
    var cancelButtonText: String {
        "Cancel"
    }
    
    var editButtonText: String {
        "Done"
    }
}

private extension LessonFormViewModel {
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma dd.MM.yyyy"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
}
