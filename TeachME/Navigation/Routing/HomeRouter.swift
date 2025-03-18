//
//  HomeRouter.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation
import SwiftUI

class HomeRouter {
    @Published var path = [Destination]()

    let theme: Theme
    let user: UserItem
    
    let userRepository: UserRepository
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userMapper: UserMapper
    let lessonMapper: LessonMapper

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

extension HomeRouter: Router {
    var initialDestination: some View {
        let viewModel = LessonListScreenViewModel(
            router: self,
            repository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userRepository: userRepository,
            mapper: lessonMapper,
            userMapper: userMapper
        )
            
        return LessonListScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
