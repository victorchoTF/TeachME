//
//  ProfileScreen.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import SwiftUI

struct ProfileScreen: View {
    let viewModel: ProfileScreenViewModel
    let theme: Theme
    
    var body: some View {
        VStack {
            userCard
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ActionButton(title: viewModel.editButtonText, theme: theme) {
                            print("Edit")
                        }
                    }
                }
            Spacer()
        }
    }
}

private extension ProfileScreen {
    @ViewBuilder
    var userCard: some View {
        if let user = viewModel.userItem {
            UserCard(user: user, theme: theme)
                .frame(maxWidth: .infinity)
        } else {
            // TODO: Implement in another PR
            Text("Loading...")
        }
    }
}
