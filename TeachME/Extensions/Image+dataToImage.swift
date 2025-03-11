//
//  Image+dataToImage.swift
//  TeachME
//
//  Created by TumbaDev on 11.03.25.
//

import Foundation
import SwiftUI

extension Image {
    func dataToImage(_ data: Data?) -> Self {
        guard let profilePictureData = data,
              let image = UIImage(data: profilePictureData) else {
            return self
        }
        
        return Image(uiImage: image)
    }
}
