//
//  SwiftUIView.swift
//  TeachME
//
//  Created by TumbaDev on 23.01.25.
//

import SwiftUI

struct SubmitButton: View {
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
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, theme.spacings.medium)
        .background(theme.colors.accent)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        .cornerRadius(theme.radiuses.medium)
    }
}
