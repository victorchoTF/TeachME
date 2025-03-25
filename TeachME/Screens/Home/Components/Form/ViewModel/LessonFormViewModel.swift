//
//  LessonFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation

final class LessonFormViewModel: ObservableObject, Identifiable {
    @Published var showAlert: Bool = false
    @Published var lessonType: String
    @Published var subtitle: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var lessonTypes: [String] = []
    
    private let lesson: LessonItem?
    private let teacher: UserLessonBodyItem
    private let formType: FormType
    private let repository: LessonTypeRepository
    
    private let dateFormatter: DateFormatter
    
    private let setLesson: (LessonItem) -> ()
    let onCancel: () -> ()
    
    init(
        lesson: LessonItem? = nil,
        teacher: UserLessonBodyItem,
        formType: FormType,
        repository: LessonTypeRepository,
        dateFormatter: DateFormatter,
        onCancel: @escaping () -> (),
        setLesson: @escaping (LessonItem) -> ()
    ) {
        self.lesson = lesson
        self.onCancel = onCancel
        self.setLesson = setLesson
        self.formType = formType
        self.repository = repository
        self.dateFormatter = dateFormatter
        
        self.lessonType = lesson?.lessonType ?? "Other"
        self.subtitle = lesson?.subtitle ?? ""
        
        let setDate: (String?) -> (Date) = { date in
            guard let date = date, !date.isEmpty else {
                return Date()
            }
                
            return dateFormatter.toDate(dateString: date) ?? Date()
        }
        
        self.startDate = setDate(lesson?.startDate)
        self.endDate = setDate(lesson?.endDate)
        
        self.teacher = teacher
    }

    func onSubmit() {
        guard let lesson = lesson else {
            return
        }
        
        let lessonItem = LessonItem(
            id: lesson.id,
            lessonType: lessonType,
            subtitle: subtitle,
            startDate: dateFormatter.toString(startDate),
            endDate: dateFormatter.toString(endDate),
            teacher: teacher
        )
        
        setLesson(lessonItem)
    }
    
    func loadData() async {
        do {
            lessonTypes = try await self.repository.getAll().map { $0.name }
        } catch {
            showAlert = true
        }
        
        lessonType = lessonTypes.first ?? "Other"
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
    
    var alertMessage: String {
        "Couldn't load lesson!\nPlease try again."
    }
}
