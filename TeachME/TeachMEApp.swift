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
    let appRouter: AppRouter
    
    init() {
        let roleMapper = RoleMapper()
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        let httpClient = URLSession(configuration: .ephemeral)
        let keychainStore = KeychainStore(identifier: KeychainStoreConstants.identifier)
        let tokenService = TokenService(
            key: KeychainStoreConstants.tokensKey,
            keychainStore: keychainStore,
            encoder: jsonEncoder,
            decoder: jsonDecoder
        )
        
        let tokenDecoder = TokenDecoder(jsonDecoder: jsonDecoder)
        
        let authRepository = AuthRepository(
            dataSource: AuthDataSource(
                client: httpClient,
                baseURL: Endpoints.baseURL,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: AuthMapper(),
            tokenSetter: tokenService
        )
        
        let authHTTPClient = AuthHTTPClient(
            tokenProvider: tokenService,
            tokenDecoder: tokenDecoder,
            authRepository: authRepository,
            httpClient: httpClient
        )
        
        let roleRepository = RoleRepository(
            dataSource: RoleDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.rolesURL,
                encoder: jsonEncoder,
                decoder: jsonDecoder,
                fetchAllURL: Endpoints.fetchAllRolesURL
            ),
            mapper: roleMapper
        )
        
        let roleProvider = RoleProvider.create(repository: roleRepository)
        
        let userMapper = UserMapper(
            userDetailMapper: UserDetailMapper(),
            roleMapper: roleMapper,
            roleProvider: roleProvider
        )
        
        let userRepository = UserRepository(
            dataSource: UserDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.usersURL,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper
        )
        
        let lessonMapper = LessonMapper(
            lessonTypeMapper: LessonTypeMapper(),
            userMapper: userMapper,
            dateFormatter: DateFormatter()
        )
        
        let lessonRepository = LessonRepository(
            dataSource: LessonDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.lessonsURL,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: lessonMapper
        )
        
        let lessonTypeRepository = LessonTypeRepository(
            dataSource: LessonTypeDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.lessonTypesURL,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: LessonTypeMapper()
        )
        
        let emailValidator = EmailValidator(patternProvider: PatternProvider())
        
        theme = PrimaryTheme()
        
        appRouter = AppRouter(
            authRepository: authRepository,
            userRepository: userRepository,
            roleRepository: roleRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper,
            roleProvider: roleProvider,
            emailValidator: emailValidator,
            tokenService: tokenService,
            tokenDecoder: tokenDecoder,
            theme: theme
        )
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(
                theme: theme,
                router: appRouter
            )
        }
    }
}
