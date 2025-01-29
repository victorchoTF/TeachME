//
//  Header.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import SwiftUI

struct Header: View {
    let theme: Theme
    
    var body: some View {
        HStack {
            Image("Logo")
                .padding(.bottom, theme.spacings.medium)
        }
        .frame(maxWidth: .infinity)
        .background(theme.colors.accent)
    }
}
