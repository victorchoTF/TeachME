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
    let user: UserItem
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userRepository: UserRepository
    let lessonMapper: LessonMapper
    let userMapper: UserMapper

    init(theme: Theme, user: UserItem) {
        self.theme = theme
        self.user = user
        
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        
        let authHTTPCLient = AuthHTTPClient(
            tokenProvider: TokenService(
                key: "token", // TODO: Handle in a better way
                keychainStore: KeychainStore(identifier: "com.teachME.tokens"), // TODO: Handle in a better way,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            httpClient: URLSession(configuration: .ephemeral)
        )
        
        userMapper = UserMapper(
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
                client: authHTTPCLient,
                baseURL: Endpoints.lessonsURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: lessonMapper
        )
        
        lessonTypeRepository = LessonTypeRepository(
            dataSource: LessonTypeDataSource(
                client: authHTTPCLient,
                baseURL: Endpoints.lessonTypesURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: LessonTypeMapper()
        )
        
        userRepository = UserRepository(
            dataSource: UserDataSource(
                client: authHTTPCLient,
                baseURL: Endpoints.usersURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper
        )
    }
}

extension HomeRouter: Router {
    @MainActor
    var initialDestination: some View {
        let viewModel = LessonListScreenViewModel(
            router: self,
            repository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userRepository: userRepository,
            mapper: lessonMapper,
            userMapper: userMapper
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
