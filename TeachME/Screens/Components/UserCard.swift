//
//  UserCard.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import SwiftUI

struct UserCard: View {
    let user: UserItem
    
    let theme: Theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacings.medium) {
            userContacts
            
            biography
        }
        .padding(theme.spacings.medium)
        .background(theme.colors.secondary)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        .foregroundStyle(theme.colors.text)
        .padding([.horizontal, .bottom], theme.spacings.medium)
    }
}

private extension UserCard {
    var userContacts: some View {
        HStack(spacing: theme.spacings.large) {
            user.profilePicture
                .resizable()
                .frame(
                    width: theme.frames.large,
                    height: theme.frames.large
                )
            
            VStack(alignment: .leading, spacing: theme.spacings.small) {
                Text(user.name)
                    .font(theme.fonts.headline)
                
                contacts
            }
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
}
