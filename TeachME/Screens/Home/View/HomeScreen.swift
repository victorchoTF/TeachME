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
            switch viewModel.lessonListState {
            case .empty: noLessonsLabel
            case .hasItems: lessonList
            }
        }
        .background(theme.colors.primary)
        .toolbar {
            if viewModel.isTeacher {
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
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertMessage))
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
                    theme: theme,
                    lessonCardType: .teacher
                )
                .lineLimit(1)
                .truncationMode(.tail)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    viewModel.onLessonTap(lesson: lesson, theme: theme)
                }
            }
            .onDelete(perform: viewModel.onDelete)
        }
        .refreshable {
            await viewModel.loadData()
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(theme.colors.primary)
    }
    
    var noLessonsLabel: some View {
        VStack {
            Text(viewModel.noLessonsText)
                .multilineTextAlignment(.center)
                .background(theme.colors.primary)
                .foregroundStyle(theme.colors.text)
                .font(theme.fonts.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
