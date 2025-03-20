//
//  TeachMEApp.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

@main
struct TeachMEApp: App {
    let theme: Theme

    let authRouter: AuthRouter
    let tabRouterFacade: TabRouterFacade
    
    init() {
        let roleMapper = RoleMapper()
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        let httpClient = URLSession(configuration: .ephemeral)
        let keychainStore = KeychainStore(identifier: "com.teachME.tokens")
        let tokenService = TokenService(
            key: "token",
            keychainStore: keychainStore,
            encoder: jsonEncoder,
            decoder: jsonDecoder
        )
        
        let authHTTPClient = AuthHTTPClient(
            tokenProvider: tokenService,
            httpClient: httpClient
        )
        
        let userMapper = UserMapper(
            userDetailMapper: UserDetailMapper(),
            roleMapper: roleMapper
        )
        
        let authRepository = AuthRepository(
            dataSource: AuthDataSource(
                client: httpClient,
                baseURL: Endpoints.baseURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper,
            tokenSetter: tokenService
        )
        
        let userRepository = UserRepository(
            dataSource: UserDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.usersURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper
        )
        
        let roleRepository = RoleRepository(
            dataSource: RoleDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.rolesURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: roleMapper
        )
        
        let lessonMapper = LessonMapper(
            lessonTypeMapper: LessonTypeMapper(),
            userMapper: userMapper,
            dateFormatter: DateFormatter()
        )
        
        let lessonRepository = LessonRepository(
            dataSource: LessonDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.lessonsURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: lessonMapper
        )
        
        let lessonTypeRepository = LessonTypeRepository(
            dataSource: LessonTypeDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.lessonTypesURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: LessonTypeMapper()
        )
        
        theme = PrimaryTheme()
        
        authRouter = AuthRouter(
            theme: theme,
            authRepository: authRepository,
            userRepository: userRepository,
            roleRepository: roleRepository,
            userMapper: userMapper
        )
        
        tabRouterFacade = TabRouterFacade(
            theme: theme,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                theme: theme,
                authRouter: authRouter,
                tabRouterFacade: tabRouterFacade
            )
        }
    }
}
