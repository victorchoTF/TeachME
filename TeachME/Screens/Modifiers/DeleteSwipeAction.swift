//
//  DeleteSwipeAction.swift
//  TeachME
//
//  Created by TumbaDev on 4.04.25.
//

import SwiftUI

struct DeleteSwipeAction<Item: Identifiable>: ViewModifier {
    let label: Label<Text, Image>
    let theme: Theme
    
    let item: Item
    let action: ((Item) -> ())?
    
    func body(content: Content) -> some View {
        if let action = action {
            content
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        action(item)
                    } label: {
                        label
                    }
                    .tint(theme.colors.error)
                }
        } else {
            content
        }
    }
}

extension View {
    func deleteSwipeAction<Item: Identifiable>(
        label: Label<Text, Image>,
        theme: Theme,
        item: Item,
        action: ((Item) -> ())?
    ) -> some View {
        return modifier(DeleteSwipeAction(label: label, theme: theme, item: item, action: action))
    }
}
