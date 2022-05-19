// 
//  WLView.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  

import UIKit

/// A shared subclass to remove common boilerplate.
/// Since app does not use interface builder `required init?(coder: NSCoder)` is made unavailable.
class WLView: UIView {
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    func configure() {
        
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            colorThemeDidChange()
        }   
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            contentSizeDidChange()
        }
    }
    
    func colorThemeDidChange() {
        
    }
    
    func contentSizeDidChange() {
        
    }
}
