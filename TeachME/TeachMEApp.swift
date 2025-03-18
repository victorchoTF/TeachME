//
//  TeachMEApp.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

@main
struct TeachMEApp: App {
    let authRepository: AuthRepository
    let userRepository: UserRepository
    let roleRepository: RoleRepository
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userMapper: UserMapper
    let lessonMapper: LessonMapper
    
    init() {
        let roleMapper = RoleMapper()
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        let httpClient = URLSession(configuration: .ephemeral)
        let keychainStore = KeychainStore(identifier: "com.teachME.tokens") // TODO: Handle in a better way
        let tokenService = TokenService(
            key: "token", // TODO: Handle in a better way
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
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                authRepository: authRepository,
                userRepository: userRepository,
                roleRepository: roleRepository,
                lessonRepository: lessonRepository,
                lessonTypeRepository: lessonTypeRepository,
                userMapper: userMapper,
                lessonMapper: lessonMapper
            )
        }
    }
}
