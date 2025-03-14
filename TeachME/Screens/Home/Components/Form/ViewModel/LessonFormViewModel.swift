//
//  LessonFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation

@MainActor final class LessonFormViewModel: ObservableObject, Identifiable {
    @Published var lessonType: String
    @Published var subtitle: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var lessonTypes: [String] = []
    
    let lesson: LessonItem
    let formType: FormType
    let repository: LessonTypeRepository
    
    let dateFormatter: DateFormatter
    
    private let updateLesson: (LessonItem) -> ()
    let onCancel: () -> ()
    
    init(
        lesson: LessonItem,
        formType: FormType,
        repository: LessonTypeRepository,
        dateFormatter: DateFormatter,
        onCancel: @escaping () -> (),
        updateLesson: @escaping (LessonItem) -> ()
    ) {
        self.lesson = lesson
        self.onCancel = onCancel
        self.updateLesson = updateLesson
        self.formType = formType
        self.repository = repository
        self.dateFormatter = dateFormatter
        
        self.lessonType = lesson.lessonType
        self.subtitle = lesson.subtitle
        
        let setDate: (String) -> (Date) = { date in
            if date.isEmpty {
                return Date()
            }
                
            return dateFormatter.toDate(dateString: date) ?? Date()
        }
        
        self.startDate = setDate(lesson.startDate)
        self.endDate = setDate(lesson.endDate)
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
    
    func loadData() async {
        do {
            lessonTypes = try await self.repository.getAll().map { $0.name }
        } catch {
            lessonTypes = ["Other"]
        }
        
        lessonType = lessonTypes[0]
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
