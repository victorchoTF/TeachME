//
//  Theme.swift
//  TeachME
//
//  Created by TumbaDev on 23.01.25.
//

import Foundation

protocol Theme {
    var colors: Colors { get }
    var spacings: Spacings { get }
    var radiuses: Radiuses { get }
    var fonts: Fonts { get }
}

struct PrimaryTheme: Theme {
    var colors: Colors
    var spacings: Spacings
    var radiuses: Radiuses
    var fonts: Fonts
}
