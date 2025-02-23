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
    let formType: FormType
    
    let dateFormatter: DateFormatter
    
    private let updateLesson: (LessonItem) -> ()
    let onCancel: () -> ()
    
    init(
        lesson: LessonItem,
        formType: FormType,
        dateFormatter: DateFormatter,
        onCancel: @escaping() -> (),
        updateLesson: @escaping (LessonItem) -> ()
    ) throws {
        self.lesson = lesson
        self.onCancel = onCancel
        self.updateLesson = updateLesson
        self.formType = formType
        self.dateFormatter = dateFormatter
        
        self.lessonType = lesson.lessonType
        self.subtitle = lesson.subtitle
        
        let setDate: (String) throws -> (Date) = { date in
            if date.isEmpty {
                return Date()
            }
                
            guard let date = dateFormatter.toDate(dateString: date) else {
                throw LessonFormError.invalidDate(
                    "Date: \(date) is not a valid date"
                )
            }
                
            return date
        }
        
        self.startDate = try setDate(lesson.startDate)
        self.endDate = try setDate(lesson.endDate)
    }

    func onSubmit() {
        let lesson = LessonItem(
            id: UUID(),
            lessonType: lessonType,
            subtitle: subtitle,
            startDate: dateFormatter.toString(startDate),
            endDate: dateFormatter.toString(endDate),
            teacherProfilePicture: lesson.teacherProfilePicture,
            teacherName: lesson.teacherName
        )
        
        updateLesson(lesson)
    }
    
    var formTitle: String {
        "\(formType.rawValue) your lesson"
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
    
    var doneButtonText: String {
        "Done"
    }
}

enum LessonFormError: Error {
    case invalidDate(String)
}
