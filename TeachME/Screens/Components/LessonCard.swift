//
//  LessonCard.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

struct LessonCard: View {
    let lesson: LessonItem
    let teacherProfilePicture: Image
    
    let theme: Theme
    
    var body: some View {
        VStack (alignment: .leading, spacing: theme.spacings.medium) {
            Text(lesson.lessonType)
                .font(theme.fonts.headline)
            
            Text(lesson.subtitle)
                .font(theme.fonts.body)
            
            additionalInfo
        }
        .padding(theme.spacings.small)
        .foregroundStyle(theme.colors.text)
        .background(theme.colors.secondaryAccent)
        .clipShape(RoundedRectangle(cornerRadius: theme.radiuses.medium))
        
        
    }
}

private extension LessonCard {
    var additionalInfo: some View {
        HStack {
            timeLabel
            
            Spacer()
            
            profileLabel
        }
    }
    
    var timeLabel: some View {
        VStack(alignment: .leading, spacing: theme.spacings.extraSmall) {
            Text(lesson.startDate)
                .font(theme.fonts.footnote)
            
            Text(lesson.endDate)
                .font(theme.fonts.footnote)
        }
    }
    
    var profileLabel: some View {
        HStack {
            teacherProfilePicture
            Text(lesson.teacherName)
                .font(theme.fonts.footnote)
        }
    }
}

#Preview {
    LessonCard(
        lesson: LessonItem(
            id: UUID(),
            lessonType: "Chemistry",
            subtitle: "Learning the basics of evening equations",
            startDate: "Start: 10:00AM 14.03.2025",
            endDate: "End: 11:40AM 14.03.2025",
            teacherName: "George Demo"
        ),
        teacherProfilePicture: Image(systemName: "person.crop.circle"),
        theme: PrimaryTheme()
    )
}
