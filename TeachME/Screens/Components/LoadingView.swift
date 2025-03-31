//
//  LoadingView.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import SwiftUI

struct LoadingView: View {
    let theme: Theme
    
    let circleSize: CGFloat = 3
    
    var body: some View {
        ZStack {
            VStack {
                Header(theme: theme)
                Spacer()
            }
                
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(circleSize)
        }
    }
}
