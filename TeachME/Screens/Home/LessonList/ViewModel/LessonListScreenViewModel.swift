//
//  LessonListScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import Foundation
import SwiftUI // TODO: Remove after DataLoading is implemented

final class LessonListScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem] = []
    
    private weak var router: HomeRouter?
    @Published var lessonFormViewModel: LessonFormViewModel?
    
    @Published var userItem: UserItem?
    
    private let repository: LessonRepository
    private let mapper: LessonMapper
    
    init(router: HomeRouter, repository: LessonRepository, mapper: LessonMapper) {
        self.router = router
        self.repository = repository
        self.mapper = mapper
    }
    
    // TODO: Should load real data in future
    func loadData() async {
        userItem = UserItem(
            name: "George Demo",
            profilePicture: Image(systemName: "person.crop.circle"),
            email: "george_demo@gmail.com",
            phoneNumber: "0874567243",
            bio: "I am competent in every field regarding high school education. I love working with my students and making them a better version of themselves"
        )
        
        do {
            lessons = try await repository.getAll().map { mapper.modelToItem($0) }
        } catch {
            lessons = []
        }
    }
    
    func onLessonTap(lesson: LessonItem, theme: Theme) {
        guard let router = router else {
            return
        }
        
        router.push(
            .lesson(
                LessonPickScreenViewModel(
                    pickedLesson: lesson,
                    router: router
                ),
                theme
            )
        )
    }
    
    var shouldShowAddLessonButton: Bool {
        router?.userRole == .teacher
    }
    
    func onAddButtonTap() {
        guard let userItem = userItem else {
            return
        }
        
        self.lessonFormViewModel = LessonFormViewModel(
            lesson: emptyLessonItem(userItem: userItem),
            formType: FormType.add,
            dateFormatter: DateFormatter(),
            onCancel: { [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            self?.lessons.removeAll(where: { $0 == lesson })
            self?.lessons.insert(
                lesson,
                at: 0
            )
            self?.lessonFormViewModel = nil
        }
    }
}

private extension LessonListScreenViewModel {
    func emptyLessonItem(userItem: UserItem) -> LessonItem {
        LessonItem(
            id: UUID(),
            lessonType: "Maths",
            subtitle: "",
            startDate: "",
            endDate: "",
            teacherProfilePicture: userItem.profilePicture,
            teacherName: userItem.name
        )
    }
}
