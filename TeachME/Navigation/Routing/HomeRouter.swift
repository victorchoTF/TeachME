//
//  HomeRouter.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import Foundation
import SwiftUI

final class HomeRouter: ObservableObject {
    @Published var path = [Destination]()

    private let theme: Theme
    let user: UserItem
    
    private let userRepository: UserRepository
    private let lessonRepository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userMapper: UserMapper
    private let lessonMapper: LessonMapper
    
    private let roleProvider: RoleProvider

    init(
        theme: Theme,
        user: UserItem,
        userRepository: UserRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper,
        roleProvider: RoleProvider
    ) {
        self.theme = theme
        self.user = user
        
        self.userRepository = userRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
        self.roleProvider = roleProvider
    }
}

extension HomeRouter: Router {
    var initialDestination: some View {
        let viewModel = HomeScreenViewModel(
            router: self,
            user: user,
            repository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userRepository: userRepository,
            mapper: lessonMapper,
            userMapper: userMapper,
            roleProvider: roleProvider
        )
            
        return HomeScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
