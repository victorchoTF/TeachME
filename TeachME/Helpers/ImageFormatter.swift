//
//  ImageFormatter.swift
//  TeachME
//
//  Created by TumbaDev on 23.03.25.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImageFormatter {
    func compressImage(
        _ image: UIImage,
        maxFileSize: Int = 1_000_000,
        minQuality: CGFloat = 0.1
    ) -> Data? {
        var compression: CGFloat = 0.8
        var imageData = image.jpegData(compressionQuality: compression)

        while let data = imageData, data.count > maxFileSize, compression > minQuality {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }
        
        return imageData
    }
    
    func resizeImage(_ image: UIImage, maxWidth: CGFloat, maxHeight: CGFloat) -> UIImage {
        let aspectRatio = image.size.width / image.size.height
        let newSize: CGSize

        if aspectRatio > 1 {
            newSize = CGSize(width: maxWidth, height: maxWidth / aspectRatio)
        } else {
            newSize = CGSize(width: maxHeight * aspectRatio, height: maxHeight)
        }
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
    
    func cropImageToSquare(_ image: UIImage) -> UIImage {
        let aspectRatio = image.size.width / image.size.height
        let squareSize: CGFloat
        
        if aspectRatio > 1 {
            squareSize = image.size.height
        } else {
            squareSize = image.size.width
        }

        let x = (image.size.width - squareSize) / 2
        let y = (image.size.height - squareSize) / 2
        let cropRect = CGRect(x: x, y: y, width: squareSize, height: squareSize)

        guard let cgImage = image.cgImage?.cropping(to: cropRect) else {
            return image
        }
        
        return UIImage(cgImage: cgImage)
    }
}
