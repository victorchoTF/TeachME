//
//  ProfileScreen.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    @StateObject var viewModel: ProfileScreenViewModel
    let theme: Theme
    
    init(viewModel: ProfileScreenViewModel, theme: Theme) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.theme = theme
    }
    
    var body: some View {
        VStack {
            profileCard
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ActionButton(
                            buttonContent: .text(
                                Text(viewModel.editButtonText)
                            )
                        ) {
                            viewModel.openEditProfile()
                        }
                        .foregroundStyle(theme.colors.accent)
                    }
                }
                .sheet(item: $viewModel.editProfileFormViewModel) { editProfileFormViewModel in
                    EditProfileForm(
                        viewModel: editProfileFormViewModel,
                        theme: theme
                    )
                    .background(theme.colors.primary)
                }
            
                Spacer()
            }
            .background(theme.colors.primary)
        }
    }

private extension ProfileScreen {
    @ViewBuilder
    var profileCard: some View {
        if let userItem = viewModel.userItem {
            ProfileCard(
                user: userItem,
                theme: theme,
                imageSelection: $viewModel.imageSelection
            )
        }
    }
}
