//
//  LessonCard.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

struct LessonCard: View {
    let lesson: LessonItem
    
    let theme: Theme
    
    let userProfilePictureSize: CGFloat = 20
    
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
            lesson.teacher.profilePicture
                .resizable()
                .frame(
                    width: userProfilePictureSize,
                    height: userProfilePictureSize
                )
                .clipShape(Circle())
            
            Text(lesson.teacher.name)
                .font(theme.fonts.footnote)
        }
    }
}
