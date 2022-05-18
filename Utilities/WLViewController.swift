// 
//  WLViewController.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  

import UIKit

class WLViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure()
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
