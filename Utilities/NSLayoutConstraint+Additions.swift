// 
//  NSLayoutConstraint+Additions.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  

import UIKit
    
extension NSLayoutConstraint {
    @discardableResult
    func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
    
    @discardableResult
    func setTo(_ reference: inout NSLayoutConstraint?) -> Self {
        reference = self
        return self
    }
}
