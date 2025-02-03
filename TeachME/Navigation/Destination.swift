//
//  Destination.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import Foundation
import SwiftUI

enum Destination {
    case lesson(LessonPickScreenViewModel, Theme)
}

extension Destination: Hashable {
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
        case (.lesson, .lesson):
            return true
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Destination: View {
    var body: some View {
        switch self {
        case let .lesson(viewModel, theme):
            LessonPickScreen(viewModel: viewModel, theme: theme)
        }
    }
}
