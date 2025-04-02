//
//  LessonScreen.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

struct LessonScreen: View {
    @StateObject var viewModel: LessonScreenViewModel
    let theme: Theme
    
    init(viewModel: LessonScreenViewModel, theme: Theme) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.theme = theme
    }
    
    var body: some View {
        VStack(spacing: theme.spacings.medium) {
            switch viewModel.lessonListState {
            case .empty: noLessonsLabel
            case .hasItems(let lessons): lessonList(lessons: lessons)
            }
        }
        .background(theme.colors.primary)
        .alert(item: $viewModel.alertItem) { alertItem in
            if case AlertType.phone(_) = alertItem.alertType {
                Alert(
                    title: Text(alertItem.message),
                    primaryButton: .default(
                        Text(viewModel.sendMailAlertText),
                        action: viewModel.sendMailAlertAction
                    ),
                    secondaryButton: .destructive(
                        Text(viewModel.cancelMailAlertText),
                        action: viewModel.cancelAlertAction
                    )
                )
            } else {
                Alert(title: Text(alertItem.message))
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
}

private extension LessonScreen {
    func lessonList(lessons: [LessonItem]) -> some View {
        List {
            ForEach(lessons) { lesson in
                LessonCard(
                    lesson: lesson,
                    theme: theme,
                    lessonCardType: viewModel.lessonCardType
                )
                .lineLimit(1)
                .truncationMode(.tail)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .onTapGesture {
                    viewModel.onLessonTap(lesson: lesson)
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
