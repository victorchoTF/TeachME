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
                .font(theme.fonts.system18)
                .foregroundStyle(theme.colors.light)
        }
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, theme.spacings.spacing10)
        .background(theme.colors.green)
        .cornerRadius(theme.radiuses.radius8)
    }
}
