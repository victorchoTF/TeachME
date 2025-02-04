//
//  TabRouter.swift
//  TeachME
//
//  Created by TumbaDev on 4.02.25.
//

import Foundation

final class TabRouter: ObservableObject {
    let homeRouter: HomeRouter = HomeRouter()
    
    let lessonRouter: HomeRouter = HomeRouter()
    let profileRouter: HomeRouter = HomeRouter()
    
    @Published var selectedTab: Tab = .home {
        willSet {
            if newValue == selectedTab {
                currentTabRouter.popToRoot()
            }
        }
    }
    
    private var currentTabRouter: Router {
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
