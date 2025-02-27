//
//  TabRouter.swift
//  TeachME
//
//  Created by TumbaDev on 4.02.25.
//

import Foundation

final class TabRouter: ObservableObject {
    let homeRouter: HomeRouter
    let lessonRouter: HomeRouter
    let profileRouter: ProfileRouter
    let userRole: Role
    
    @Published var selectedTab: Tab = .home {
        willSet {
            if newValue == selectedTab {
                currentTabRouter.popToRoot()
            }
        }
    }
    
    init(theme: Theme) {
        userRole = .teacher
        homeRouter = HomeRouter(theme: theme, userRole: userRole)
        lessonRouter = HomeRouter(theme: theme, userRole: userRole)
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
