// 
//  Store.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import Foundation

class Store {
    var wishlist: [String] = []
    
    func saveChanges() {
        NotificationCenter.default.post(name: .StoreDidSave, object: self)
    }
}


// MARK: Notifications

extension Notification.Name {
    static let StoreDidSave: NSNotification.Name = {
        .init(rawValue: "StoreDidSave")
    }()
}
