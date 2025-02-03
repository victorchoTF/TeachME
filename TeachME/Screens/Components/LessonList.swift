//
//  LessonList.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

struct LessonList: View {
    let lessons: [LessonItem]
    let onLessonTapped: (LessonItem) -> ()
    
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
                .onTapGesture {
                    onLessonTapped(lesson)
                }
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
}
