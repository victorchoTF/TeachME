//
//  ActionButton.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let theme: Theme
    
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
        }
    }
}
