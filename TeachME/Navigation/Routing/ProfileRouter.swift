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
    
    init(theme: Theme) {
        self.theme = theme
    }
    
}

extension ProfileRouter: Router {
    var initialDestination: some View {
        let viewModel = ProfileScreenViewModel()

        return ProfileScreen(viewModel: viewModel, theme: theme)
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
