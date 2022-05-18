// 
//  AppContainerVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class AppContainerVC: UITabBarController {
    let env: AppEnvironment
    
    var venuesVC: OfferingsVC!
    var exhibitionsVC: OfferingsVC!
    var wishListVC: OfferingsVC!
    
    init(env: AppEnvironment) {
        self.env = env
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesVC = OfferingsVC(env: env, config: .venues)
        exhibitionsVC = OfferingsVC(env: env, config: .exhibitions)
        wishListVC = OfferingsVC(env: env, config: .wishList)
        
        viewControllers = [
            UINavigationController(rootViewController: venuesVC),
            UINavigationController(rootViewController: exhibitionsVC),
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
        
        venuesVC.tabBarItem = .init(title: Strings.venuesTitle, image: .tabBarVenues(), selectedImage: .tabBarVenuesSelected())
        exhibitionsVC.tabBarItem = .init(title: Strings.exhibitionsTitle, image: .tabBarExhibitions(), selectedImage: .tabBarExhibitionsSelected())
        wishListVC.tabBarItem = .init(title: Strings.wishListTitle, image: .tabBarWishList(), selectedImage: .tabBarWishListSelected())
    }
}


// MARK: - Notifications

@objc extension AppContainerVC {
    func contentSizeCategoryDidChange() {
        reloadTabBar()
    }
}
