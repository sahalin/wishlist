// 
//  Theme.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

// MARK: Text styles

extension TextAttributes {
    static func offeringCardTitle() -> Self {
        [.font: UIFont.preferredFont(forTextStyle: .title3, weight: .medium), .foregroundColor: Colors.text]
    }
}


// MARK: Tab bar

extension UIImage {
    static func tabBarAttractions() -> UIImage {
        .systemSFSymbol("map")
    }
    
    static func tabBarAttractionsSelected() -> UIImage {
        .systemSFSymbol("map.fill", color: Colors.tint)
    }
    
    static func tabBarWishList() -> UIImage {
        .systemSFSymbol("heart")
    }
    
    static func tabBarWishListSelected() -> UIImage {
        .systemSFSymbol("heart.fill", color: Colors.tint)
    }
}

extension UITabBarAppearance {
    static func standard() -> UITabBarAppearance {
        let a = UITabBarAppearance()
        a.configureWithDefaultBackground()
        a.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Colors.tintTabBarSelected]
        return a
    }
    
    static func scrollEdge() -> UITabBarAppearance {
        let a = standard()
        a.configureWithTransparentBackground()
        return a
    }
}
