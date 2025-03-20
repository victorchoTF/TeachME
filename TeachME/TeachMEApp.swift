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

    let appViewModel: AppViewModel
    
    init() {
        let roleMapper = RoleMapper()
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        let httpClient = URLSession(configuration: .ephemeral)
        let keychainStore = KeychainStore(identifier: "com.teachME.tokens") // FIXME: find a better way
        let tokenService = TokenService(
            key: "token", // FIXME: find a better way
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
        
        appViewModel = AppViewModel(
            authRepository: authRepository,
            userRepository: userRepository,
            roleRepository: roleRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(
                theme: theme,
                viewModel: appViewModel
            )
        }
    }
}
