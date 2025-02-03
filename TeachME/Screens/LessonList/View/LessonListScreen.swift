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
            LessonList(
                lessons: viewModel.lessons,
                onLessonTapped: viewModel.onLessonTapped,
                theme: theme
            )
        }
        .background(theme.colors.primary)
    }
}
