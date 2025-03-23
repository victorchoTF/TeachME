//
//  HomeScreen.swift
//  TeachME
//
//  Created by TumbaDev on 29.01.25.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel: HomeScreenViewModel
    let theme: Theme
    
    init(viewModel: HomeScreenViewModel, theme: Theme) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.theme = theme
    }
    
    var body: some View {
        VStack(spacing: theme.spacings.medium) {
            lessonList
        }
        .background(theme.colors.primary)
        .toolbar {
            if viewModel.shouldShowAddLessonButton {
                ToolbarItem(placement: .topBarTrailing) {
                    ActionButton(
                        buttonContent: .icon(
                            Image(systemName: "plus")
                        )
                    ) {
                        viewModel.onAddButtonTap()
                    }
                    .foregroundStyle(theme.colors.accent)
                }
            }
        }
        .sheet(item: $viewModel.lessonFormViewModel) { lessonFormViewModel in
            LessonForm(
                viewModel: lessonFormViewModel,
                theme: theme
            )
            .background(theme.colors.primary)
        }
        .task {
            await viewModel.loadData()
        }
    }
}

private extension HomeScreen {
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
                    viewModel.onLessonTap(lesson: lesson, theme: theme)
                }
            }
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
    }
}
