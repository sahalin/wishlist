// 
//  WishListVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class WishListVC: WLViewController {
    init(env: AppEnvironment) {
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Strings.wishListTitle
        view.backgroundColor = .systemBackground
    }
}
