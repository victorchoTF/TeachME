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
        VStack(spacing: theme.spacings.large) {
            Header(theme: theme)
            
            LessonList(lessons: viewModel.lessons, theme: theme)
        }
    }
}
