//
//  SwitchFormText.swift
//  TeachME
//
//  Created by TumbaDev on 23.01.25.
//

import SwiftUI

struct SwitchFormText: View {
    let text: String
    let clickableText: String
    let theme: Theme
    let switchAction: () -> ()
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(theme.colors.dark)
            Button {
                withAnimation {
                    switchAction()
                }
            } label: {
                Text(clickableText)
                    .bold()
                    .underline()
                    .foregroundStyle(theme.colors.dark)
            }
        }
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowSeparator(.hidden)
    }
}
