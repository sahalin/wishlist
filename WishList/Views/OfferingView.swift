// 
//  OfferingView.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

class OfferingView: WLView {
    let offering: Offering
    
    init(offering: Offering) {
        self.offering = offering
        super.init()
    }
}
