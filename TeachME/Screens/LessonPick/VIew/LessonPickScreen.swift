//
//  LessonPickScreen.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import SwiftUI

struct LessonPickScreen: View {
    @ObservedObject var viewModel: LessonPickScreenViewModel
    
    let theme: Theme
    
    var body: some View {
        VStack {
            ScrollView {
                lessonCard
                
                teacherCard
                
                VStack(alignment: .leading) {
                    Text(viewModel.moreAboutTitle)
                        .font(theme.fonts.title)
                        .padding(.horizontal, theme.spacings.small)
                    
                    
                }
                
                VStack(alignment: .leading) {
                    Text(viewModel.otherLessonsTitle)
                        .font(theme.fonts.title)
                        .padding(.horizontal, theme.spacings.small)
                    
                    otherLessonsList
                }
            }
        }
        .background(theme.colors.primary)
        .navigationTitle(viewModel.pickedLesson.lessonType)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ActionButton(title: viewModel.pickLessonButtonText, theme: theme) {
                    print("Saved")
                }
            }
        }
        .onAppear(perform: viewModel.loadData)
    }
}

private extension LessonPickScreen {
    var lessonCard: some View {
        VStack(alignment: .leading, spacing: theme.spacings.large) {
            HStack(spacing: theme.spacings.extraLarge) {
                startDate
                endDate
            }
            
            description
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(theme.colors.text)
        .padding(theme.spacings.small)
    }
    
    @ViewBuilder
    var teacherCard: some View {
        if let teacher = viewModel.teacher {
            UserCard(user: teacher, theme: theme)
                .frame(maxWidth: .infinity)
        } else {
            // TODO: Implement in another PR
            Text("Loading...")
        }
    }
    
    var otherLessonsList: some View {
        VStack {
            ForEach(viewModel.otherLessons) { lesson in
                LessonCard(
                    lesson: lesson,
                    theme: theme
                )
                .onTapGesture {
                    viewModel.onLessonTap(lesson: lesson)
                }
            }
        }
        .padding(.horizontal, theme.spacings.medium)
    }
    
    var startDate: some View {
        VStack(alignment: .leading) {
            Text("Starts at")
                .foregroundStyle(.opacity(0.6))
            
            Text(viewModel.pickedLesson.startDate)
                .font(theme.fonts.body)
                .padding(theme.spacings.extraSmall)
                .background(theme.colors.secondaryAccent)
                .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        }
    }
    
    var endDate: some View {
        VStack(alignment: .leading) {
            Text("Ends at")
                .foregroundStyle(.opacity(0.6))
            
            Text(viewModel.pickedLesson.endDate)
                .font(theme.fonts.body)
                .padding(theme.spacings.extraSmall)
                .background(theme.colors.secondaryAccent)
                .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        }
    }
    
    var description: some View {
        VStack(alignment: .leading) {
            Text("Description")
                .foregroundStyle(.opacity(0.6))
            
            Text(viewModel.pickedLesson.subtitle)
                .font(theme.fonts.body)
                .padding(theme.spacings.small)
                .background(theme.colors.secondaryAccent)
                .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        }
    }
}
