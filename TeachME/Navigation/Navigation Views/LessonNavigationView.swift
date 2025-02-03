//
//  LessonNavigationView.swift
//  TeachME
//
//  Created by TumbaDev on 3.02.25.
//

import SwiftUI

struct LessonNavigationView: View {
    let title: String
    @StateObject var lessons: LessonsRouter
    
    var body: some View {
        NavigationStack(path: $lessons.path) {
            lessons.initialDestination
                .navigationDestination(for: Destination.self) { $0 }
                .navigationTitle(title)
        }
    }
}
