//
//  LessonNavigationView.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import SwiftUI

struct LessonNavigationView: View {
    let title: String
    @ObservedObject var router: HomeRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            router.initialDestination
                .navigationDestination(for: Destination.self) { $0 }
                .navigationTitle(title)
        }
    }
}
