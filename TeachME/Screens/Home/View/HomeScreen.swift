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
            case .hasItems(let lessons): lessonList(lessons: lessons)
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
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.message))
        }
        .task {
            await viewModel.loadData()
        }
    }
}

private extension HomeScreen {
    func lessonList(lessons: [LessonItem]) -> some View {
        List {
            ForEach(lessons) { lesson in
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

//
//struct HomeScreen: View {
//    ...
//    var body: some View {
//        VStack(spacing: theme.spacings.medium) {
//            switch viewModel.lessonListState {
//            case .empty: noLessonsLabel
//            case .hasItems(let lessons): lessonList(lessons: lessons)
//            }
//        }
//        ...
//    }
//}
//
//private extension HomeScreen {
//    func lessonList(lessons: [LessonItem]) -> some View {...}
//    ...
//}
//
//final class HomeScreenViewModel: ObservableObject {
//    @Published var lessonListState: LessonListState = .empty
//    ...
//    
//    // TODO: Show alert on catch
//    func loadData() async {
//        let lessons: [LessonItem]
//        do {
//            if user.role == .Teacher {
//                lessons = try await repository.getLessonsByTeacherId(user.id).filter {
//                    $0.student == nil
//                }
//                .map {
//                    mapper.modelToItem($0)
//                }
//            } else {
//                lessons = try await repository.getOpenLessons().map {
//                    mapper.modelToItem($0)
//                }
//            }
//        } catch {
//            lessonListState = .empty
//            return
//        }
//        
//        lessonListState = .hasItems(lessons)
//    }
//    
//    var lessons: [LessonItem] {
//        switch lessonListState {
//        case .empty: []
//        case .hasItems(let lessons): lessons
//        }
//    }
//    ...
//    
//    func teacherOnDelete(at offsets: IndexSet) {
//        var lessons = lessons
//        
//        offsets.map { lessons[$0] }.forEach { lesson in
//            deleteLesson(lessonId: lesson.id)
//        }
//        
//        lessons.remove(atOffsets: offsets)
//        
//        lessonListState = .hasItems(lessons)
//    }
//    ...
//}
//
//private extension HomeScreenViewModel {
//    func setLesson(lesson: LessonItem) async throws {
//        guard let lessonItem = try await addLesson(lesson: lesson) else {
//            lessonFormViewModel = nil
//            return
//        }
//        
//        var lessons = lessons
//        
//        lessons.removeAll(where: { $0 == lessonItem })
//        lessons.insert(
//            lessonItem,
//            at: 0
//        )
//        
//        lessonListState = .hasItems(lessons)
//        
//        lessonFormViewModel = nil
//    }
//    ...
//}
//
