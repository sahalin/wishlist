// 
//  OfferingView+IconDetailLabel.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

extension OfferingView {
    class IconLabel: WLView {
        private let imageView = UIImageView()
        private let label = UILabel()
        
        private let reservedImageGuide = UILayoutGuide()
        private var reservedImageWidthConstraint: NSLayoutConstraint!
        private var spacingConstraint: NSLayoutConstraint!
        
        private let theme: Theme
        
        init(theme: Theme) {
            self.theme = theme
            super.init()
        }
        
        override func configure() {
            // Layout
            addSubview(imageView)
            addSubview(label)
            addLayoutGuide(reservedImageGuide)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                reservedImageGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
                reservedImageGuide.widthAnchor.constraint(equalToConstant: theme.detailIconSize).setTo(&reservedImageWidthConstraint),
                label.topAnchor.constraint(equalTo: topAnchor),
                label.leadingAnchor.constraint(equalTo: reservedImageGuide.trailingAnchor).setTo(&spacingConstraint),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.centerXAnchor.constraint(equalTo: reservedImageGuide.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            
            // Configure subviews
            imageView.preferredSymbolConfiguration = .init(textStyle: theme.detailIconTextStyle, scale: theme.detailIconScale)
            imageView.adjustsImageSizeForAccessibilityContentSizeCategory = false
            label.numberOfLines = 0
            label.adjustsFontForContentSizeCategory = true
        }
        
        override func contentSizeDidChange() {
            reservedImageWidthConstraint.constant = UIFontMetrics(forTextStyle: theme.detailIconTextStyle).scaledValue(for: theme.detailIconSize, compatibleWith: traitCollection)
            spacingConstraint.constant = UIFontMetrics(forTextStyle: theme.detailIconTextStyle).scaledValue(for: theme.detailIconSpacing, compatibleWith: traitCollection)
        }
        
        // MARK: Reload
        
        func reload(icon: UIImage, text: String) {
            imageView.image = icon
            label.attributedText = text.attributed(with: theme.detailTextAttributes)
            spacingConstraint.constant = theme.detailIconSpacing
        }
    }
}
