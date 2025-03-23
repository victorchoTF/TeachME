//
//  LessonScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

final class LessonScreenViewModel: ObservableObject {
    @Published var lessons: [LessonItem] = []
    
    private weak var router: LessonRouter?
    
    private let repository: LessonRepository
    private let mapper: LessonMapper
    
    init(router: LessonRouter? = nil, repository: LessonRepository, mapper: LessonMapper) {
        self.router = router
        self.repository = repository
        self.mapper = mapper
    }
    
    func loadData() async {
        guard let user = router?.user else {
            return
        }
        
        do {
            if user.role == .Teacher {
                lessons = try await repository.getLessonsByTeacherId(user.id).filter {
                    $0.student != nil
                }
                .map {
                    mapper.modelToItem($0)
                }
            } else {
                lessons = try await repository.getLessonsByStudentId(user.id).map {
                    mapper.modelToItem($0)
                }
            }
        } catch {
            lessons = []
        }
    }
    
    // TODO: Implement DeepLink logic
    func onLessonTap() {
        print("LessonTapped")
    }
}
