// 
//  UIImage+Additions.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  

import UIKit

extension UIImage {
    static func systemSFSymbol(_ name: String, scale: UIImage.SymbolScale = .large, color: UIColor? = nil) -> UIImage {
        let config = UIImage.SymbolConfiguration(scale: scale)
        guard let image = UIImage(systemName: name, withConfiguration: config) else {
            assertionFailure("No system SFSymbol. Check name")
            return UIImage()
        }
        if let color = color {
            return image.withRenderingMode(.alwaysOriginal).withTintColor(color)
        }
        return image
    }
}
