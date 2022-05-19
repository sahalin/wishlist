// 
//  Store.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import Foundation

class Store {
    /// An array of Offering uniqueIDs.
    lazy var wishList: [String] = {
        if let data = try? Data(contentsOf: wishListLocalURL) {
            return try! JSONDecoder().decode([String].self, from: data)
        }
        return []
    }()
    
    func saveChanges() {
        let data = try! JSONEncoder().encode(wishList)
        try! data.write(to: wishListLocalURL, options: [.atomic])
        
        NotificationCenter.default.post(name: .StoreDidSave, object: self)
    }
    
    private var wishListLocalURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            .appendingPathComponent("WishList")
    }
}


// MARK: Notifications

extension Notification.Name {
    static let StoreDidSave: NSNotification.Name = {
        .init(rawValue: "StoreDidSave")
    }()
}
