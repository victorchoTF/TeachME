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
            userCard
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ActionButton(title: viewModel.editButtonText, theme: theme) {
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
            .onAppear(perform: viewModel.loadData)
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
