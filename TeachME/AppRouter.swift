//
//  AppRouter.swift
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

final class AppRouter: ObservableObject {
    @Published private var state: AppState = .auth

    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    private let roleRepository: RoleRepository
    private let lessonRepository: LessonRepository
    private let lessonTypeRepository: LessonTypeRepository
    private let userMapper: UserMapper
    private let lessonMapper: LessonMapper
    private let roleMapper: RoleMapper
    private let theme: Theme
    private let emailValidator: EmailValidator

    init(
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        roleMapper: RoleMapper,
        lessonMapper: LessonMapper,
        emailValidator: EmailValidator,
        theme: Theme
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.roleMapper = roleMapper
        self.lessonMapper = lessonMapper
        self.emailValidator = emailValidator
        self.theme = theme
    }
    
    
    @ViewBuilder
    var initialDestination: some View {
        switch state {
        case .idle(let user):
            TeachMETabView(
                theme: theme,
                tabRouter: tabRouter(user: user, theme: theme)
            )
        case .auth:
            AuthScreen(viewModel: authScreenViewModel, theme: theme)
        case .loading:
            LoadingView(theme: theme)
        }
    }
}

private extension AppRouter {
    func didLogIn(user: UserItem) {
        state = .idle(user)
    }
    
    func tabRouter(user: UserItem, theme: Theme) -> TabRouter {
        TabRouter(
            homeRouter: HomeRouter(
                theme: theme,
                user: user,
                userRepository: userRepository,
                lessonRepository: lessonRepository,
                lessonTypeRepository: lessonTypeRepository,
                userMapper: userMapper,
                lessonMapper: lessonMapper
            ),
            lessonRouter: LessonRouter(
                theme: theme,
                user: user,
                userRepository: userRepository,
                lessonRepository: lessonRepository,
                lessonTypeRepository: lessonTypeRepository,
                userMapper: userMapper,
                lessonMapper: lessonMapper
            ),
            profileRouter: ProfileRouter(
                theme: theme,
                user: user,
                userRepository: userRepository,
                mapper: userMapper,
                emailValidator: emailValidator
            )
        )
    }
    
    var authScreenViewModel: AuthScreenViewModel {
        AuthScreenViewModel(
            loginFormViewModel: LoginFormViewModel(
                authRepository: authRepository,
                userRepository: userRepository,
                userMapper: userMapper,
                emailValidator: emailValidator
            ) { [weak self] userItem in
                self?.didLogIn(user: userItem)
            },
            registerFormsViewModel: RegisterFormViewModel(
                authRepository: authRepository,
                userRepository: userRepository,
                roleRepository: roleRepository,
                userMapper: userMapper,
                emailValidator: emailValidator,
                roleMapper: roleMapper
            ) { [weak self] userItem in
                self?.didLogIn(user: userItem)
            }
        )
    }
}
