//
//  ContentView.swift
//  TeachME
//
//  Created by TumbaDev on 19.01.25.
//

import SwiftUI

struct ContentView: View {
    let theme = PrimaryTheme()
    
    var body: some View {
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
}

#Preview {
    ContentView()
}
