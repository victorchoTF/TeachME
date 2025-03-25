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
    
    private let lessonRepository: LessonRepository
    private let lessonMapper: LessonMapper

    init(
        theme: Theme,
        user: UserItem,
        lessonRepository: LessonRepository,
        lessonMapper: LessonMapper
    ) {
        self.theme = theme
        self.user = user
        
        self.lessonRepository = lessonRepository
        self.lessonMapper = lessonMapper
    }
}

extension LessonRouter: Router {
    var initialDestination: some View {
        let viewModel = LessonScreenViewModel(
            router: self,
            user: user,
            repository: lessonRepository,
            mapper: lessonMapper
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
