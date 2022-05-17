// 
//  AppContainerVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class AppContainerVC: UITabBarController {
    let env: AppEnvironment
    
    var attractionsVC: AttractionsVC!
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
        
        attractionsVC = AttractionsVC(env: env)
        wishListVC = WishListVC(env: env)
        
        viewControllers = [
            UINavigationController(rootViewController: attractionsVC),
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
        
        attractionsVC.tabBarItem = .init(title: Strings.attractionsTitle, image: .systemSFSymbol("circle"), selectedImage: .systemSFSymbol("circle.fill", color: Colors.tint))
        wishListVC.tabBarItem = .init(title: Strings.wishListTitle, image: .systemSFSymbol("circle"), selectedImage: .systemSFSymbol("circle.fill", color: Colors.tint))
    }
}


// MARK: - Notifications

@objc extension AppContainerVC {
    func contentSizeCategoryDidChange() {
        reloadTabBar()
    }
}
