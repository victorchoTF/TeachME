//
//  ActionButton.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import SwiftUI

struct ActionButton: View {
    let buttonContent: ActionButtonContent
    let theme: Theme
    
    let action: () -> ()
    
    init(buttonContent: ActionButtonContent, theme: Theme, action: @escaping () -> Void) {
        self.buttonContent = buttonContent
        self.theme = theme
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            switch buttonContent {
            case .text(let text):
                text
            case .icon(let icon):
                icon
            }
        }
    }
}

enum ActionButtonContent {
    case text(Text)
    case icon(Image)
}
