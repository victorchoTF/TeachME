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
    
    @Published var userItem: UserItem
    
    @Published var selectedTab: Tab = .home {
        willSet {
            if newValue == selectedTab {
                currentTabRouter.popToRoot()
            }
        }
    }
    
    //FIXME: Updating loading state issue
    init(theme: Theme) {
        let userItem = UserItem(
            id: UUID(),
            name: "Loading",
            email: "...",
            phoneNumber: "...",
            bio: "...",
            role: .Teacher
        )
        
        self.userItem = userItem
        
        homeRouter = HomeRouter(theme: theme, user: userItem)
        lessonRouter = HomeRouter(theme: theme, user: userItem)
        profileRouter = ProfileRouter(theme: theme, user: userItem)
    }
    
    func update(userItem: UserItem, theme: Theme) {
        self.userItem = userItem
        
        homeRouter = HomeRouter(theme: theme, user: userItem)
        lessonRouter = HomeRouter(theme: theme, user: userItem)
        profileRouter = ProfileRouter(theme: theme, user: userItem)
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
