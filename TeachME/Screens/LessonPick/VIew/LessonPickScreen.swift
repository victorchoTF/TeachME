//
//  LessonPickScreen.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import SwiftUI

struct LessonPickScreen: View {
    let viewModel: LessonPickScreenViewModel
    
    let theme: Theme
    
    var body: some View {
        VStack {
            Header(theme: theme)
            
            lessonCard
            
            Text(viewModel.moreAboutTitle)
                .font(theme.fonts.title)
            
            UserCard(user: viewModel.teacher, theme: theme)
            
            Text(viewModel.otherLessonsTitle)
                .font(theme.fonts.title)
            
            LessonList(lessons: viewModel.otherLessons, theme: theme)
        }
        .background(theme.colors.primary)
    }
}

private extension LessonPickScreen {
    var lessonCard: some View {
        VStack(spacing: theme.spacings.small) {
            LessonCard(lesson: viewModel.lesson, theme: theme)
            
            ActionButton(
                text: viewModel.pickLessonButtonText,
                theme: theme
            )
        }
        .padding(theme.spacings.small)
        .background(theme.colors.secondaryAccent)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        .padding(theme.spacings.medium)
    }
}
