//
//  LessonRouter.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import Foundation
import SwiftUI

final class LessonRouter: ObservableObject {
    @Published var path = [Destination]()

    private let theme: Theme
    let user: UserItem
    
    private let userRepository: UserRepository
    private let lessonRepository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userMapper: UserMapper
    private let lessonMapper: LessonMapper

    init(
        theme: Theme,
        user: UserItem,
        userRepository: UserRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper
    ) {
        self.theme = theme
        self.user = user
        
        self.userRepository = userRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
    }
}

extension LessonRouter: Router {
    var initialDestination: some View {
        let viewModel = LessonScreenViewModel(
            router: self,
            user: user,
            repository: lessonRepository,
            userRepository: userRepository,
            lessonTypeRepository: lessonTypeRepository,
            mapper: lessonMapper,
            userMapper: userMapper,
            isTeacher: user.role == .Teacher,
            lessonCardType: user.role == .Teacher ? .student : .teacher
        )
            
        return LessonScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
