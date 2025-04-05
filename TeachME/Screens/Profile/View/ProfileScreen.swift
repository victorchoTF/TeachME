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
                        settings
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
            .alert($viewModel.alertItem)
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
    
    var editButtonLabel: Label<Text, Image> {
        Label(
            viewModel.editButtonText,
            systemImage: viewModel.editButtonIcon
        )
    }
    
    var logOutButtonLabel: Label<Text, Image> {
        Label(
            viewModel.logOutButtonText,
            systemImage: viewModel.logOutButtonIcon
        )
    }
    
    var settings: some View {
        Menu {
            ActionButton(
                buttonContent: .label(editButtonLabel)
            ){
                viewModel.openEditProfile()
            }

            ActionButton(
                buttonContent: .label(logOutButtonLabel)
            ){
                viewModel.logOut()
            }
        } label: {
            Image(systemName: viewModel.settingsIcon)
        }
        .foregroundStyle(theme.colors.accent)
    }
}
