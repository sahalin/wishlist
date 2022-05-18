// 
//  WLCustomViewCell.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

final class WLCustomViewListCell<View: UIView>: UICollectionViewListCell {
    var customView: View!
    
    /// Making unavailable as the cell is initialized during dequeue by the collection view.
    @available(*, unavailable)
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    func setCustomView(_ handler: () -> View) {
        if customView == nil {
            customView = handler()
            
            contentView.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                customView.topAnchor.constraint(equalTo: contentView.topAnchor),
                customView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                customView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            ])
        }
    }
}
