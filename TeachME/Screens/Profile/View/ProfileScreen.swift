//
//  ProfileScreen.swift
//  TeachME
//
//  Created by TumbaDev on 8.02.25.
//

import SwiftUI

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
                        Menu {
                            ActionButton(
                                buttonContent: .label(
                                    Label (
                                        viewModel.editButtonText,
                                        systemImage: viewModel.editButtonIcon
                                    )
                                )
                            ) {
                                viewModel.openEditProfile()
                            }
                            
                            ActionButton(
                                buttonContent: .label(
                                    Label(
                                        viewModel.logOutButtonText,
                                        systemImage: viewModel.logOutButtonIcon
                                    )
                                )
                            ) {
                                viewModel.logOut()
                            }
                        } label: {
                            Image(systemName: viewModel.settingsIcon)
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
            .alert(isPresented: $viewModel.updateImageAlert) {
                Alert(
                    title: Text(viewModel.imageAlertMessage),
                    primaryButton: .default(
                        Text(viewModel.imageAlertAccept),
                        action: viewModel.updateProfilePicture
                    ),
                    secondaryButton: .destructive(
                        Text(viewModel.imageAlertCancel),
                        action: viewModel.cancelProfilePictureUpdate
                    )
                )
            }
        }
    }

private extension ProfileScreen {
    @ViewBuilder
    var profileCard: some View {
        ProfileCard(
            user: viewModel.user,
            theme: theme,
            imageSelection: $viewModel.imageSelection
        )
        .background(theme.colors.primary)
        .frame(maxWidth: .infinity)
    }
}
