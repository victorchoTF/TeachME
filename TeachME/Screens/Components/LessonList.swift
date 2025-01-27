//
//  LessonList.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

struct LessonList: View {
    let lessons: [LessonDisplay]
    
    let theme: Theme
    
    var body: some View {
        List {
            ForEach(lessons) { lesson in
                LessonCard(
                    lesson: lesson,
                    teacherProfilePicture: Image(systemName: "person.crop.circle"),
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
