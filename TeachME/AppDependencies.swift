//
//  AppDependencies.swift
//  TeachME
//
//  Created by TumbaDev on 18.03.25.
//

import Foundation

final class AppDependencies {
    let theme: Theme
    let authRepository: AuthRepository
    let userRepository: UserRepository
    let roleRepository: RoleRepository
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userMapper: UserMapper
    let lessonMapper: LessonMapper

    lazy var authRouter: AuthRouter = createAuthRouter()
    lazy var tabRouter: TabRouter = createTabRouter()

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
        
        userMapper = UserMapper(
            userDetailMapper: UserDetailMapper(),
            roleMapper: roleMapper
        )
        
        authRepository = AuthRepository(
            dataSource: AuthDataSource(
                client: httpClient,
                baseURL: Endpoints.baseURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper,
            tokenSetter: tokenService
        )
        
        userRepository = UserRepository(
            dataSource: UserDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.usersURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper
        )
        
        roleRepository = RoleRepository(
            dataSource: RoleDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.rolesURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: roleMapper
        )
        
        lessonMapper = LessonMapper(
            lessonTypeMapper: LessonTypeMapper(),
            userMapper: userMapper,
            dateFormatter: DateFormatter()
        )
        
        lessonRepository = LessonRepository(
            dataSource: LessonDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.lessonsURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: lessonMapper
        )
        
        lessonTypeRepository = LessonTypeRepository(
            dataSource: LessonTypeDataSource(
                client: authHTTPClient,
                baseURL: Endpoints.lessonTypesURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: LessonTypeMapper()
        )
        
        theme = PrimaryTheme()
    }
}

private extension AppDependencies {
    func createTabRouter() -> TabRouter {
        let homeRouter = HomeRouter(
            theme: theme,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )

        let lessonRouter = HomeRouter(
            theme: theme,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )

        let profileRouter = ProfileRouter(
            theme: theme,
            userRepository: userRepository,
            mapper: userMapper
        )

        return TabRouter(
            homeRouter: homeRouter,
            lessonRouter: lessonRouter,
            profileRouter: profileRouter
        ) { [weak self] tabRouter, userItem in
            self?.tabRouter.homeRouter.user = userItem
            self?.tabRouter.lessonRouter.user = userItem
        }
    }

    func createAuthRouter() -> AuthRouter {
        return AuthRouter(
            theme: theme,
            authRepository: authRepository,
            userRepository: userRepository,
            roleRepository: roleRepository,
            userMapper: userMapper
        ) { [weak self] userItem in
            self?.tabRouter.update(self?.tabRouter, userItem)
        }
    }
}
