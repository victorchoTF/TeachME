//
//  ProfileScreen.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import SwiftUI

struct ProfileScreen: View {
    @ObservedObject var viewModel: ProfileScreenViewModel
    let theme: Theme
    
    var body: some View {
        VStack {
            userCard
                .background(theme.colors.primary)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ActionButton(title: viewModel.editButtonText, theme: theme) {
                            viewModel.isEditingProfile = true
                        }
                        .foregroundStyle(theme.colors.accent)
                    }
                }
                .sheet(isPresented: $viewModel.isEditingProfile) {
                    if let user = viewModel.userItem {
                        EditProfileForm(
                            viewModel: EditProfileFormViewModel(
                                email: user.email,
                                firstName: String(user.name.split(separator: " ")[0]),
                                lastName: String(user.name.split(separator: " ")[1]),
                                phoneNumber: user.phoneNumber,
                                bio: user.bio
                            ),
                            isEditingProfile: $viewModel.isEditingProfile,
                            theme: theme
                        )
                        .background(theme.colors.primary)
                    }
                }
            Spacer()
        }
        .background(theme.colors.primary)
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
