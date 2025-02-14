//
//  TeacherHomeScreen.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import SwiftUI

struct TeacherHomeScreen: View {
    @StateObject var viewModel: TeacherHomeScreenViewModel
    let theme: Theme
    
    init(viewModel: TeacherHomeScreenViewModel, theme: Theme) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.theme = theme
    }
    
    var body: some View {
        VStack {
            lessonList
        }
    }
}

private extension TeacherHomeScreen {
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
                    viewModel.onLessonTap(lesson)
                }
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .sheet(item: $viewModel.selectedLesson) { lesson in
            if let editLessonFormViewModel = viewModel.editLessonFormViewModel {
                EditLessonForm(
                    viewModel: editLessonFormViewModel,
                    theme: theme
                )
            }
        }
    }
}
