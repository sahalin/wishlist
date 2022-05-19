// 
//  OfferingView+Theme.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

extension OfferingView {
    struct Theme {
        var corners: CGFloat = 16
        
        var imageWidth: CGFloat = 100
        var imageMinHeight: CGFloat = 100
        
        var contentMargins: NSDirectionalEdgeInsets = .init(top: 12, leading: 8, bottom: 12, trailing: 12)
        var contentSpacing: CGFloat = 8
        
        var titleAttributes: TextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: .headline),
            .foregroundColor: Colors.text
        ]
        
        var detailTextAttributes: TextAttributes = [
            .font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular),
            .foregroundColor: Colors.text
        ]
        
        var detailIconSize: CGFloat = 24
        var detailIconSpacing: CGFloat = 6
        var detailIconTextStyle: UIFont.TextStyle = .subheadline
        var detailIconScale: UIImage.SymbolScale = .medium
        
        var locationIcon: UIImage = .systemSFSymbol("mappin.circle.fill", hierarchicalColor: Colors.tint)
        var dateIcon: UIImage = .systemSFSymbol("calendar.circle.fill", hierarchicalColor: Colors.tint)
        var priceIcon: UIImage = .systemSFSymbol("creditcard.circle.fill", hierarchicalColor: Colors.tint)
        var starsIcon: UIImage = .systemSFSymbol("star.circle.fill", color: .systemYellow)
        
        var addToWishListButtonIcon: UIImage = .systemSFSymbol("heart")
        var addedTowishListButtonIcon: UIImage = .systemSFSymbol("heart.fill")
        var wishListButtonIconSpacing: CGFloat = 4
        var wishListButtonColor: UIColor = .systemPink
    }
}
