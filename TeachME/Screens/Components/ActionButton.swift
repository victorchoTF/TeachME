//
//  ActionButton.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import SwiftUI

struct ActionButton: View {
    let text: String
    let theme: Theme
    
    var body: some View {
        Button {
            print("Action")
        } label: {
            Text(text)
                .fontWeight(.bold)
                .font(theme.fonts.headline)
                .foregroundStyle(theme.colors.secondary)
        }
        .padding(.vertical, theme.spacings.medium)
        .padding(.horizontal, theme.spacings.extraLarge)
        .background(theme.colors.accent)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
    }
}
