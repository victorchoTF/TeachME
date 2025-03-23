//
//  LessonCard.swift
//  TeachME
//
//  Created by TumbaDev on 27.01.25.
//

import SwiftUI

enum LessonCardType {
    case student
    case teacher
}

struct LessonCard: View {
    let lesson: LessonItem
    
    let theme: Theme
    
    let userProfilePictureSize: CGFloat = 20
    let lessonCardType: LessonCardType
    
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
            
            switch lessonCardType {
            case .student: studentProfileLabel
            case .teacher: teacherProfileLabel
            }
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
    
    var teacherProfileLabel: some View {
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
    
    @ViewBuilder
    var studentProfileLabel: some View {
        if let student = lesson.student {
            HStack {
                student.profilePicture
                    .resizable()
                    .frame(
                        width: userProfilePictureSize,
                        height: userProfilePictureSize
                    )
                    .clipShape(Circle())
                
                Text(student.name)
                    .font(theme.fonts.footnote)
            }
        }
    }
}
