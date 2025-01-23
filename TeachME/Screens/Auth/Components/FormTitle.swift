//
//  FormTitle.swift
//  TeachME
//
//  Created by TumbaDev on 23.01.25.
//

import SwiftUI

struct FormTitle: View {
    let title: String
    let theme: Theme
    
    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .font(theme.fonts.system20)
            .foregroundStyle(theme.colors.dark)
    }
}
