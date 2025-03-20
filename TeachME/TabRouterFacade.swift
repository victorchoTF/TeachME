//
//  TabRouterFacade.swift
//  TeachME
//
//  Created by TumbaDev on 18.03.25.
//

import Foundation

@MainActor final class TabRouterFacade: ObservableObject {
    @Published var tabRouter: TabRouter?
    
    let theme: Theme
    let userRepository: UserRepository
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userMapper: UserMapper
    let lessonMapper: LessonMapper
    
    init(
        tabRouter: TabRouter? = nil,
        theme: Theme,
        userRepository: UserRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper
    ) {
        self.tabRouter = tabRouter
        self.theme = theme
        self.userRepository = userRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
    }
    
    func initTabRouter(user: UserItem) {
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

        let profileRouter = ProfileRouter(theme: theme)

        tabRouter = TabRouter(
            homeRouter: homeRouter,
            lessonRouter: lessonRouter,
            profileRouter: profileRouter
        )
    }
    
    var selectedTab: Tab {
        get {
            guard let tab = tabRouter?.selectedTab else {
                return .home
            }
            
            return tab
        }
        set(newTab) {
            tabRouter?.selectedTab = newTab
        }
    }
    
    var homeRouter: any Router {
        guard let homeRouter = tabRouter?.homeRouter else {
            return EmptyRouter()
        }
        
        return homeRouter
    }
    
    var lessonRouter: any Router {
        guard let lessonRouter = tabRouter?.lessonRouter else {
            return EmptyRouter()
        }
        
        return lessonRouter
    }
    
    var profileRouter: any Router {
        guard let profileRouter = tabRouter?.profileRouter else {
            return EmptyRouter()
        }
        
        return profileRouter
    }
}
