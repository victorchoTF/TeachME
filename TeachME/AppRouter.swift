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
    private let theme: Theme
    
    private let roleProvider: RoleProvider
    private let emailValidator: EmailValidator
    
    init(
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper,
        roleProvider: RoleProvider,
        emailValidator: EmailValidator,
        theme: Theme
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
        self.roleProvider = roleProvider
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
                lessonMapper: lessonMapper,
                roleProvider: roleProvider
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
                rolePorvider: roleProvider,
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
                roleProvider: roleProvider,
                emailValidator: emailValidator
            ) { [weak self] userItem in
                self?.didLogIn(user: userItem)
            },
            registerFormsViewModel: RegisterFormViewModel(
                authRepository: authRepository,
                userRepository: userRepository,
                roleRepository: roleRepository,
                userMapper: userMapper,
                roleProvider: roleProvider,
                emailValidator: emailValidator
            ) { [weak self] userItem in
                self?.didLogIn(user: userItem)
            }
        )
    }
}
