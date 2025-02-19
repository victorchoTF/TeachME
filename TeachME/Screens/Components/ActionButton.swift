//
//  ActionButton.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import SwiftUI

struct ActionButton: View {
    let title: String?
    let icon: Image?
    let theme: Theme
    
    let action: () -> ()
    
    init(title: String? = nil, icon: Image? = nil, theme: Theme, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.theme = theme
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            if let title = title {
                Text(title)
            }
            
            icon
        }
    }
}
