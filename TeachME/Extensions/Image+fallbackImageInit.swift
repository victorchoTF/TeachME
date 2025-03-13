//
//  Image+fallbackImageInit.swift
//  TeachME
//
//  Created by TumbaDev on 11.03.25.
//

import Foundation
import SwiftUI

extension Image {
    init(data: Data?, fallbackImageName: String) {
        if let data, let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            self.init(systemName: fallbackImageName)
        }
    }
}
