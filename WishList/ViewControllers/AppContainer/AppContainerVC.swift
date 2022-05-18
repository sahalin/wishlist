// 
//  AppContainerVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class AppContainerVC: UITabBarController {
    let env: AppEnvironment
    
    var OfferingsVC: OfferingsVC!
    var wishListVC: WishListVC!
    
    init(env: AppEnvironment) {
        self.env = env
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OfferingsVC = OfferingsVC(env: env)
        wishListVC = WishListVC(env: env)
        
        viewControllers = [
            UINavigationController(rootViewController: OfferingsVC),
            UINavigationController(rootViewController: wishListVC),
        ]
        
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeCategoryDidChange), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
        reloadTabBar()
    }
}


// MARK: - Reload

extension AppContainerVC {
    func reloadTabBar() {
        tabBar.standardAppearance = .standard()
        tabBar.scrollEdgeAppearance = .scrollEdge()
        
        OfferingsVC.tabBarItem = .init(title: Strings.attractionsTitle, image: .tabBarAttractions(), selectedImage: .tabBarAttractionsSelected())
        wishListVC.tabBarItem = .init(title: Strings.wishListTitle, image: .tabBarWishList(), selectedImage: .tabBarWishListSelected())
    }
}


// MARK: - Notifications

@objc extension AppContainerVC {
    func contentSizeCategoryDidChange() {
        reloadTabBar()
    }
}
