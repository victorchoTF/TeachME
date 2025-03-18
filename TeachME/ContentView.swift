//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme: Theme
    let authRepository: AuthRepository
    let userRepository: UserRepository
    let roleRepository: RoleRepository
    let lessonRepository: LessonRepository
    let lessonTypeRepository: LessonTypeRepository
    let userMapper: UserMapper
    let lessonMapper: LessonMapper
    
    @State var isLoggedIn: Bool = false // TODO: Don't hardcode it
    @StateObject var tabRouter: TabRouter
    
    init(
        authRepository: AuthRepository,
        userRepository: UserRepository,
        roleRepository: RoleRepository,
        lessonRepository: LessonRepository,
        lessonTypeRepository: LessonTypeRepository,
        userMapper: UserMapper,
        lessonMapper: LessonMapper
    ) {
        self.theme = PrimaryTheme()
        self._tabRouter = StateObject(
            wrappedValue: TabRouter(
                theme: PrimaryTheme(),
                userRepository: userRepository,
                roleRepository: roleRepository,
                lessonRepository: lessonRepository,
                lessonTypeRepository: lessonTypeRepository,
                userMapper: userMapper,
                lessonMapper: lessonMapper
            )
        )
        
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.roleRepository = roleRepository
        self.lessonRepository = lessonRepository
        self.lessonTypeRepository = lessonTypeRepository
        self.userMapper = userMapper
        self.lessonMapper = lessonMapper
    }
    
    var body: some View {
        if isLoggedIn {
            tabView
        } else {
            authScreen
        }
    }
}

private extension ContentView {
    var authScreen: some View {
        AuthScreen(
            viewModel: AuthScreenViewModel(
                loginFormViewModel: LoginFormViewModel(
                    authRepository: authRepository,
                    userRepository: userRepository,
                    userMapper: userMapper
                ) { userItem in
                    isLoggedIn = true
                    tabRouter.update(userItem: userItem, theme: theme)
                },
                registerFormsViewModel: RegisterFormViewModel(
                    authRepository: authRepository,
                    userRepository: userRepository,
                    roleRepository: roleRepository,
                    userMapper: userMapper
                ) { userItem in
                    isLoggedIn = true
                    tabRouter.update(userItem: userItem, theme: theme)
                }
            ),
            theme: theme
        )
    }
    
    var tabView: some View {
        TabView(selection: $tabRouter.selectedTab) {
            homeScreen
                .tag(Tab.home)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            lessonScreen
                .tag(Tab.lessons)
                .tabItem {
                    Label("Lessons", systemImage: "graduationcap.fill")
                }
            
            profileScreen
                .tag(Tab.profile)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .tint(theme.colors.accent)
        .background(theme.colors.primary)
        .foregroundStyle(theme.colors.text)
    }
    
    var homeScreen: some View {
        RouterView(title: "Home", router: tabRouter.homeRouter)
    }
    
    var lessonScreen: some View {
        RouterView(title: "Lessons", router: tabRouter.lessonRouter)
    }
    
    var profileScreen: some View {
        RouterView(title: "Profile", router: tabRouter.profileRouter)
    }
}
