//
//  IdleScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.03.25.
//

import Foundation

final class IdleScreenViewModel: ObservableObject {
    @Published var tabRouter: TabRouter
    
    init(
        user: UserItem,
        theme: Theme,
        userRepository: UserRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper
    ) {
        let homeRouter = HomeRouter(
            theme: theme,
            user: user,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
        
        let lessonRouter = HomeRouter(
            theme: theme,
            user: user,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
        
        let profileRouter = ProfileRouter(
            theme: theme,
            user: user,
            userRepository: userRepository,
            mapper: userMapper
        )
        
        tabRouter = TabRouter(
            homeRouter: homeRouter,
            lessonRouter: lessonRouter,
            profileRouter: profileRouter
        )
    }
}
