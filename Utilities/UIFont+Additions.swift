// 
//  UIFont+Additions.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

extension UIFont {
    static func preferredFont(forTextStyle style: TextStyle, weight: Weight) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: .init(preferredContentSizeCategory: .large))
        let font = UIFont.systemFont(ofSize: descriptor.pointSize, weight: weight)
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: font)
    }
}
