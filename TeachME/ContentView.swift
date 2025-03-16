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
    let userMapper: UserMapper
    @State var isLoggedIn: Bool = false
    @StateObject var tabRouter: TabRouter
    
    init() {
        self.theme = PrimaryTheme()
        self._tabRouter = StateObject(wrappedValue: TabRouter(theme: PrimaryTheme()))
        
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
                client: AuthHTTPClient(
                    tokenProvider: tokenService,
                    httpClient: httpClient
                ),
                baseURL: Endpoints.usersURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: userMapper
        )
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
                    repository: authRepository,
                    userRepository: userRepository,
                    userMapper: userMapper
                ) { userItem in
                    isLoggedIn = true
                    tabRouter.update(userItem: userItem, theme: theme)
                },
                registerFormsViewModel: RegisterFormViewModel(
                    repository: authRepository,
                    userRepository: userRepository,
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
