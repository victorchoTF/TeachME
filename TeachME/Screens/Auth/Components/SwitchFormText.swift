//
//  SwitchFormText.swift
//  TeachME
//
//  Created by TumbaDev on 23.01.25.
//

import SwiftUI

struct SwitchFormText: View {
    let text: String
    let buttonLabel: String
    let theme: Theme
    let switchAction: () -> ()
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(theme.colors.text)
            Button {
                withAnimation {
                    switchAction()
                }
            } label: {
                Text(buttonLabel)
                    .bold()
                    .underline()
                    .foregroundStyle(theme.colors.text)
            }
        }
        .listRowBackground(Color.clear)
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowSeparator(.hidden)
    }
}
