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
        VStack(spacing: 0) {
            Header(theme: theme)
            
            ScrollView {
                lessonCard
                
                VStack(alignment: .leading) {
                    Text(viewModel.moreAboutTitle)
                        .font(theme.fonts.title)
                        .padding(.horizontal, theme.spacings.small)
                    
                    UserCard(user: viewModel.teacher, theme: theme)
                        .frame(maxWidth: .infinity)
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
    }
}

private extension LessonPickScreen {
    var lessonCard: some View {
        VStack(alignment: .leading, spacing: theme.spacings.large) {
            Text(viewModel.pickedLesson.lessonType)
                .font(theme.fonts.bigTitle)
                .fontWeight(.bold)
            
            HStack(spacing: theme.spacings.extraLarge) {
                startDate
                endDate
            }
            
            description
            
        }
        .foregroundStyle(theme.colors.text)
        .padding(theme.spacings.small)
    }
    
    var otherLessonsList: some View {
        VStack {
            ForEach(viewModel.otherLessons) { lesson in
                LessonCard(
                    lesson: lesson,
                    theme: theme
                )
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
