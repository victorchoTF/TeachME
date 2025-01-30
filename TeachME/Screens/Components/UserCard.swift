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
        VStack(spacing: theme.spacings.medium) {
            imageNamePair
            
            biography
            
            contacts
        }
        .padding(theme.spacings.small)
        .background(theme.colors.secondary)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        .foregroundStyle(theme.colors.text)
        .padding([.horizontal, .bottom], theme.spacings.medium)
    }
}

private extension UserCard {
    var imageNamePair: some View {
        HStack {
            user.profilePicture
                .resizable()
                .frame(
                    width: theme.spacings.extraExtraLarge,
                    height: theme.spacings.extraExtraLarge
                )
            
            Text(user.name)
                .font(theme.fonts.headline)
        }
    }
    
    var biography: some View {
        Text(user.bio)
            .font(theme.fonts.body)
    }
    
    var contacts: some View {
        HStack(spacing: theme.spacings.extraLarge) {
            email
            
            phoneNumber
        }
    }
    
    var email: some View {
        HStack {
            Image(systemName: "envelope.fill")
            
            Text(user.email)
                .font(theme.fonts.footnote)
        }
    }
    
    var phoneNumber: some View {
        HStack {
            Image(systemName: "phone.fill")
            
            Text(user.phoneNumber)
                .font(theme.fonts.footnote)
        }
    }
}
