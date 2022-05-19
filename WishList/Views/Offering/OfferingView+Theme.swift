// 
//  OfferingView+Theme.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

extension OfferingView {
    struct Theme {
        var imageWidth: Double = 100
        var imageMinHeight: Double = 100
        
        var contentMargins: NSDirectionalEdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 0)
        var contentSpacing: Double = 8
        
        var titleAttributes: TextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: Colors.text
        ]
        
        var detailTextAttributes: TextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular),
            .foregroundColor: Colors.text
        ]
        
        var detailIconSize: Double = 24
        var detailIconSpacing: Double = 6
        var detailIconTextStyle: UIFont.TextStyle = .subheadline
        var detailIconScale: UIImage.SymbolScale = .medium
        
        var locationIcon: UIImage = .systemSFSymbol("mappin.circle.fill", hierarchicalColor: Colors.tint)
        var dateIcon: UIImage = .systemSFSymbol("calendar.circle.fill", hierarchicalColor: Colors.tint)
        var priceIcon: UIImage = .systemSFSymbol("creditcard.circle.fill", hierarchicalColor: Colors.tint)
        var starsIcon: UIImage = .systemSFSymbol("star.circle.fill", color: .systemYellow)
        
        var addToWishListButtonIcon: UIImage = .systemSFSymbol("heart")
        var addedTowishListButtonIcon: UIImage = .systemSFSymbol("heart.fill")
        var wishListButtonIconSpacing: Double = 4
    }
}
