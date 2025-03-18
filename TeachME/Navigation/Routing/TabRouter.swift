//
//  TabRouter.swift
//  TeachME
//
//  Created by TumbaDev on 4.02.25.
//

import Foundation

@MainActor final class TabRouter: ObservableObject {
    var homeRouter: HomeRouter
    var lessonRouter: HomeRouter
    var profileRouter: ProfileRouter
    
    let userRepository: UserRepository
    let roleRepository: RoleRepository
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userMapper: UserMapper
    let lessonMapper: LessonMapper
    
    @Published var userItem: UserItem
    
    @Published var selectedTab: Tab = .home {
        willSet {
            if newValue == selectedTab {
                currentTabRouter.popToRoot()
            }
        }
    }
    
    init(
        theme: Theme,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper
    ) {
        let userItem = UserItem(
            id: UUID(),
            name: "Loading",
            email: "...",
            phoneNumber: "...",
            bio: "...",
            role: .Teacher
        )
        
        self.userItem = userItem
        
        homeRouter = HomeRouter(
            theme: theme,
            user: userItem,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
        lessonRouter = HomeRouter(
            theme: theme,
            user: userItem,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
        profileRouter = ProfileRouter(theme: theme)
        
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
    }
    
    func update(userItem: UserItem, theme: Theme) {
        self.userItem = userItem
        
        homeRouter = HomeRouter(
            theme: theme,
            user: userItem,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
        lessonRouter = HomeRouter(
            theme: theme,
            user: userItem,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
        profileRouter = ProfileRouter(theme: theme)
    }
    
    private var currentTabRouter: any Router {
        switch selectedTab {
        case .home:
            return homeRouter
        case .lessons:
            return lessonRouter
        case .profile:
            return profileRouter
        }
    }
    
    func popToRoot() {
        lessonRouter.popToRoot()
    }
}
