//
//  TabRouter.swift
//  TeachME
//
//  Created by TumbaDev on 4.02.25.
//

import Foundation

final class TabRouter: ObservableObject {
    @Published var homeRouter: HomeRouter
    @Published var lessonRouter: HomeRouter
    @Published var profileRouter: ProfileRouter
    
    let update: (TabRouter?, UserItem) -> ()
    
    @Published var selectedTab: Tab = .home {
        willSet {
            if newValue == selectedTab {
                currentTabRouter.popToRoot()
            }
        }
    }
    
    //FIXME: Updating loading state issue
    init(
        homeRouter: HomeRouter,
        lessonRouter: HomeRouter, // TODO: change when LessonRouter is implemented
        profileRouter: ProfileRouter,
        update: @escaping (TabRouter?, UserItem) -> ()
    ) {
        self.homeRouter = homeRouter
        self.lessonRouter = lessonRouter
        self.profileRouter = profileRouter
        self.update = update
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
