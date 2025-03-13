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
    let roleRepository: RoleRepository
    @State var isLoggedIn: Bool
    @StateObject var tabRouter: TabRouter
    
    init() {
        self.theme = PrimaryTheme()
        self._tabRouter = StateObject(wrappedValue: TabRouter(theme: PrimaryTheme()))
        
        let roleMapper = RoleMapper()
        let jsonDecoder = JSONDecoder()
        let jsonEncoder = JSONEncoder()
        let httpClient = URLSession(configuration: .ephemeral)
        
        self.authRepository = AuthRepository(
            dataSource: AuthDataSource(
                client: httpClient,
                baseURL: Endpoints.baseURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: UserMapper(
                userDetailMapper: UserDetailMapper(),
                roleMapper: roleMapper
            ),
            tokenSetter: TokenSetter(
                key: "token", // TODO: Handle in a better way
                keychainStore: KeychainStore(identifier: "com.teachME.credentials"), // TODO: Handle in a better way,
                encoder: jsonEncoder
            )
        )
        
        self.roleRepository = RoleRepository(
            dataSource: RoleDataSource(
                client: httpClient,
                baseURL: Endpoints.baseURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: roleMapper
        )
        
        self.isLoggedIn = false
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
                    repository: authRepository
                ) {
                    isLoggedIn = true
                },
                registerFormsViewModel: RegisterFormViewModel(
                    repository: authRepository,
                    roleRepository: roleRepository
                ) {
                    isLoggedIn = true
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
