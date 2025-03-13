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
    let userRole: Role
    let lessonRepository: LessonRepository
    let lessonMapper: LessonMapper

    init(theme: Theme, userRole: Role) {
        self.theme = theme
        self.userRole = userRole
        
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        
        let userMapper = UserMapper(
            userDetailMapper: UserDetailMapper(),
            roleMapper: RoleMapper()
        )
        
        lessonMapper = LessonMapper(
            lessonTypeMapper: LessonTypeMapper(),
            userMapper: userMapper,
            dateFormatter: DateFormatter()
        )
        
        lessonRepository = LessonRepository(
            dataSource: LessonDataSource(
                client: AuthHTTPClient(
                    tokenProvider: TokenProvider(
                        key: "token", // TODO: Handle in a better way
                        keychainStore: KeychainStore(identifier: "com.teachME.tokens"), // TODO: Handle in a better way
                        decoder: jsonDecoder
                    ),
                    httpClient: URLSession(configuration: .ephemeral)
                ),
                baseURL: "teach-me", // TODO: Handle in a better way
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: lessonMapper
        )
    }
}

extension HomeRouter: Router {
    @MainActor
    var initialDestination: some View {
        let viewModel = LessonListScreenViewModel(
            router: self,
            repository: lessonRepository,
            mapper: lessonMapper
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
