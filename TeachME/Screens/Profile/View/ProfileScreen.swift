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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ActionButton(title: viewModel.editButtonText, theme: theme) {
                            viewModel.openEditProfile()
                        }
                        .foregroundStyle(theme.colors.accent)
                    }
                }
                .sheet(isPresented: $viewModel.isEditingProfile) {
                    if let editProfileFormViewModel = viewModel.editProfileFormViewModel {
                        EditProfileForm(
                            viewModel: editProfileFormViewModel,
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
                .background(theme.colors.primary)
                .frame(maxWidth: .infinity)
        } else {
            // TODO: Implement in another PR
            Text("Loading...")
        }
    }
}
