// 
//  NSAttributedString+Additions.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

typealias TextAttributes = [NSAttributedString.Key: Any]

extension String {
    func attributed(with textAttributes: TextAttributes) -> NSAttributedString {
        NSAttributedString(string: self, attributes: textAttributes)
    }
}
