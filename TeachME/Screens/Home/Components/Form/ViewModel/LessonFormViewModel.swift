//
//  LessonFormViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation

enum LessonFormType {
    case add((LessonItemBody) async throws -> ())
    case edit(LessonItem, (LessonItem) async throws -> ())
}

@MainActor final class LessonFormViewModel: ObservableObject, Identifiable {
    enum LessonFormError: Error {
        case expectedLessonButNilFound
    }

    @Published var alertItem: AlertItem? = nil
    @Published var lessonType: String
    @Published var subtitle: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var lessonTypes: [String] = []
    
    private let teacher: UserLessonBodyItem
    private let formType: FormType
    private let repository: LessonTypeRepository
    
    private let dateFormatter: DateFormatter
    
    private let lessonFormType: LessonFormType
    let onCancel: () -> ()
    
    init(
        teacher: UserLessonBodyItem,
        formType: FormType,
        repository: LessonTypeRepository,
        dateFormatter: DateFormatter,
        lessonFormType: LessonFormType,
        onCancel: @escaping () -> ()
    ) {
        self.onCancel = onCancel
        self.lessonFormType = lessonFormType
        self.formType = formType
        self.repository = repository
        self.dateFormatter = dateFormatter
        
        let setDate: (String) -> (Date) = { date in
            guard !date.isEmpty else {
                return Date()
            }
            
            return dateFormatter.toDate(dateString: date) ?? Date()
        }
        
        if case LessonFormType.edit(let lesson, _) = lessonFormType {
            self.lessonType = lesson.lessonType
            self.subtitle = lesson.subtitle
            
            self.startDate = setDate(lesson.startDate)
            self.endDate = setDate(lesson.endDate)
        } else {
            self.lessonType = "Other"
            self.subtitle = ""
            self.startDate = Date()
            self.endDate = Date()
        }
        
        
        
        self.teacher = teacher
    }
    
    func onSubmit() {
        switch lessonFormType {
        case .add(let addLesson):
            Task {
                do {
                    try await addLesson(getLessonItemBody())
                } catch {
                    if case UserExperienceError.invalidDatesError = error {
                        alertItem = AlertItem(alertType: .invalidDates)
                    }
                }
            }
        case .edit(let lesson, let editLesson):
            Task {
                do {
                    try await editLesson(getLessonItem(lessonId: lesson.id))
                } catch {
                    if case UserExperienceError.invalidDatesError = error {
                        alertItem = AlertItem(alertType: .invalidDates)
                    }
                }
            }
        }
    }
    
    func loadData() async {
        do {
            lessonTypes = try await self.repository.getAll().map { $0.name }
        } catch {
            alertItem = AlertItem(alertType: .lessonLoading)
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
}

private extension LessonFormViewModel {
    func getLessonItem(lessonId: UUID) -> LessonItem {
        return LessonItem(
            id: lessonId,
            lessonType: lessonType,
            subtitle: subtitle,
            startDate: dateFormatter.toString(startDate),
            endDate: dateFormatter.toString(endDate),
            teacher: teacher
        )
    }
    
    func getLessonItemBody() -> LessonItemBody {
        return LessonItemBody(
            lessonType: lessonType,
            subtitle: subtitle,
            startDate: dateFormatter.toString(startDate),
            endDate: dateFormatter.toString(endDate),
            teacher: teacher
        )
    }
}
