//
//  StudentHomeScreen.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import SwiftUI

struct LessonListScreen: View {
    let viewModel: LessonListScreenViewModel
    let theme: Theme
    
    var body: some View {
        VStack(spacing: theme.spacings.medium) {
            lessonList
        }
        .background(theme.colors.primary)
    }
}

private extension LessonListScreen {
    var lessonList: some View {
        List {
            ForEach(viewModel.lessons) { lesson in
                LessonCard(
                    lesson: lesson,
                    theme: theme
                )
                .lineLimit(1)
                .truncationMode(.tail)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    viewModel.onLessonTap(lesson: lesson)
                }
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
}
