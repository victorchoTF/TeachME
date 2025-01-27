//
//  LessonCard.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

struct LessonCard: View {
    let lessonType: String
    let subtitle: String
    let startDateLabel: String
    let endDateLabel: String
    let teacherProfilePicture: Image
    let teacherName: String
    
    let theme: Theme
    
    var body: some View {
        VStack (alignment: .leading, spacing: theme.spacings.medium) {
            Text(lessonType)
                .font(theme.fonts.headline)
            
            Text(subtitle)
                .font(theme.fonts.body)
            
            additionalInfo
        }
        .padding(theme.spacings.small)
        .foregroundStyle(theme.colors.text)
        .background(theme.colors.accent)
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
        VStack(spacing: theme.spacings.extraSmall) {
            Text(startDateLabel)
                .font(theme.fonts.footnote)
            
            Text(startDateLabel)
                .font(theme.fonts.footnote)
        }
    }
    
    var profileLabel: some View {
        HStack {
            teacherProfilePicture
            Text(teacherName)
                .font(theme.fonts.footnote)
        }
    }
}

#Preview {
    LessonCard(
        lessonType: "Chemistry",
        subtitle: "Learning the basics of evening equations",
        startDateLabel: "Start: 10:00AM 14.03.2025",
        endDateLabel: "End: 11:40AM 14.03.2025",
        teacherProfilePicture: Image(systemName: "person.crop.circle"),
        teacherName: "George Demo",
        theme: PrimaryTheme()
    )
}
