//
//  TeacherHomeScreen.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import SwiftUI

struct TeacherHomeScreen: View {
    @ObservedObject var viewModel: TeacherHomeScreenViewModel
    let theme: Theme
    
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
        .sheet(item: $viewModel.selectedLesson) { selectedLesson in
            Text("Editing: \(selectedLesson.lessonType)")
        }
    }
}
