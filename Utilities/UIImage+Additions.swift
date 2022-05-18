// 
//  UIImage+Additions.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  

import UIKit

extension UIImage {
    static func systemSFSymbol(_ name: String, scale: UIImage.SymbolScale = .large, textStyle: UIFont.TextStyle? = nil, color: UIColor? = nil, hierarchicalColor: UIColor? = nil) -> UIImage {
        var config: UIImage.SymbolConfiguration
        if let textStyle = textStyle {
            config = .init(textStyle: textStyle, scale: scale)
        } else {
            config = .init(scale: scale)
        }
        if let color = color {
            config = config.applying(UIImage.SymbolConfiguration(paletteColors: [color]))
        }
        if let hierarchicalColor = hierarchicalColor {
            config = config.applying(UIImage.SymbolConfiguration(hierarchicalColor: hierarchicalColor))
        }
        guard let image = UIImage(systemName: name, withConfiguration: config) else {
            assertionFailure("No system SFSymbol. Check name")
            return UIImage()
        }
        return image
    }
}
