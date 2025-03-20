//
//  AppViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 20.03.25.
//

import SwiftUI

enum AppState {
    case idle(UserItem)
    case auth
    case loading
}

final class AppViewModel: ObservableObject {
    @Published var state: AppState = .auth

    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    private let roleRepository: RoleRepository
    private let lessonRepository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userMapper: UserMapper
    private let lessonMapper: LessonMapper
    
    init(
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
    }
    
    func iddleScreenViewModel(user: UserItem, theme: Theme) -> IdleScreenViewModel {
        IdleScreenViewModel(
            user: user,
            theme: theme,
            userRepository: userRepository,
            lessonRepository: lessonRepository,
            lessonTypeRepository: lessonTypeRepository,
            userMapper: userMapper,
            lessonMapper: lessonMapper
        )
    }
    
    var authScreenViewModel: AuthScreenViewModel {
        AuthScreenViewModel(
            loginFormViewModel: LoginFormViewModel(
                authRepository: authRepository,
                userRepository: userRepository,
                userMapper: userMapper
            ) { [weak self] userItem in
                self?.state = .idle(userItem)
            },
            registerFormsViewModel: RegisterFormViewModel(
                authRepository: authRepository,
                userRepository: userRepository,
                roleRepository: roleRepository,
                userMapper: userMapper
            ) { [weak self] userItem in
                self?.state = .idle(userItem)
            }
        )
    }
}
