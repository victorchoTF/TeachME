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
    
    let action: () -> ()
    
    var body: some View {
        ActionButton(buttonContent: .text(Text(text)), action: action)
            .fontWeight(.bold)
            .font(theme.fonts.headline)
            .foregroundStyle(theme.colors.secondary)
            .listRowBackground(Color.clear)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, theme.spacings.medium)
            .background(theme.colors.accent)
            .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
    }
}


