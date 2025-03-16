//
//  ProfileRouter.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import Foundation
import SwiftUI

class ProfileRouter {
    @Published var path = [Destination]()
    
    let theme: Theme
    let user: UserItem
    
    let repository: UserRepository
    let mapper: UserMapper
    
    init(theme: Theme, user: UserItem) {
        self.theme = theme
        self.user = user
        
        let jsonEncoder = JSONEncoder()
        let jsonDecoder = JSONDecoder()
        
        mapper = UserMapper(
            userDetailMapper: UserDetailMapper(),
            roleMapper: RoleMapper()
        )
        
        repository = UserRepository(
            dataSource: UserDataSource(
                client: AuthHTTPClient(
                    tokenProvider: TokenService(
                        key: "token", // TODO: Handle in a better way
                        keychainStore: KeychainStore(identifier: "com.teachME.tokens"), // TODO: Handle in a better way,
                        encoder: jsonEncoder,
                        decoder: jsonDecoder
                    ),
                    httpClient: URLSession(configuration: .ephemeral)
                ),
                baseURL: Endpoints.usersURL.rawValue,
                encoder: jsonEncoder,
                decoder: jsonDecoder
            ),
            mapper: mapper
        )
    }
    
}

extension ProfileRouter: Router {
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel(
            userItem: user,
            repository: repository,
            mapper: mapper
        )

        return ProfileScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
