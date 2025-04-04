//
//  ProfileCard.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI
import PhotosUI

struct ProfileCard: View {
    let user: UserItem
    
    let theme: Theme
    
    @Binding var imageSelection: PhotosPickerItem?
    
    let userProfilePictureSize: CGFloat = 70
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacings.medium) {
            userContacts
            
            biography
        }
        .padding(theme.spacings.medium)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        .foregroundStyle(theme.colors.text)
    }
}

private extension ProfileCard {
    var userContacts: some View {
        HStack(spacing: theme.spacings.large) {
            profileImage
            
            VStack(alignment: .leading, spacing: theme.spacings.small) {
                Text(user.name)
                    .font(theme.fonts.headline)
                
                contacts
            }
            Spacer()
        }
    }
    
    var biography: some View {
        Text(user.bio)
            .font(theme.fonts.body)
            .multilineTextAlignment(.leading)
    }
    
    var contacts: some View {
        VStack(alignment: .leading, spacing: theme.spacings.small) {
            email
            
            phoneNumber
        }
        .foregroundStyle(.opacity(0.6))
    }
    
    var email: some View {
        HStack(spacing: theme.spacings.small) {
            Image(systemName: "envelope.fill")
            
            Text(user.email)
                .font(theme.fonts.footnote)
        }
    }
    
    var phoneNumber: some View {
        HStack(spacing: theme.spacings.small) {
            Image(systemName: "phone.fill")
            
            Text(user.phoneNumber)
                .font(theme.fonts.footnote)
        }
    }
    
    var profileImage: some View {
        user.profilePicture
            .resizable()
            .frame(
                width: userProfilePictureSize,
                height: userProfilePictureSize
            )
            .clipShape(Circle())
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(theme.colors.accent)
                }
                .buttonStyle(.borderless)
            }
    }
}

