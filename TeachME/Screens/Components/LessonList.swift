//
//  LessonList.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

struct LessonList: View {
    let lessons: [LessonItem]
    
    let theme: Theme
    
    var body: some View {
        List {
            ForEach(lessons) { lesson in
                LessonCard(
                    lesson: lesson,
                    theme: theme
                )
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
}
