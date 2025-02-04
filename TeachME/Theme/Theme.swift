//
//  Theme.swift
//  TeachME
//
//  Created by TumbaDev on 23.01.25.
//

import SwiftUI

protocol Theme {
    var colors: Colors { get }
    var spacings: Spacings { get }
    var radiuses: Radiuses { get }
    var fonts: Fonts { get }
}

struct PrimaryTheme: Theme {
    var colors: Colors = Colors(
        primary: Color("Primary"),
        secondary: Color("Secondary"),
        text: Color("Text"),
        accent: Color("Accent"),
        secondaryAccent: Color("SecondaryAccent"),
        success: Color("Success"),
        warning: Color("Warning"),
        error: Color("Error")
    )
    
    var spacings: Spacings = Spacings(
        extraSmall: 4,
        small: 8,
        medium: 10,
        large: 20,
        extraLarge: 30,
        extraExtraLarge: 40
    )
    
    var radiuses: Radiuses = Radiuses(
        medium: 8
    )
    
    var fonts: Fonts = Fonts(
        footnote: .system(size:12),
        body: .system(size: 14),
        headline: .system(size: 18),
        title: .system(size: 20),
        bigTitle: .system(size: 25)
    )
}
