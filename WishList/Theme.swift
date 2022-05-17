// 
//  Theme.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

struct Theme {
    
}

// MARK: Tab bar

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
