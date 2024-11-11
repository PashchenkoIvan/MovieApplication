//
//  ImageFilter.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 11.11.2024.
//

import UIKit
import Foundation

extension UIImage {
    func applyTint(to image: UIImage, with color: UIColor) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        filter?.setValue(CIColor(color: color), forKey: kCIInputColorKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        
        guard let outputImage = filter?.outputImage else { return nil }
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}
