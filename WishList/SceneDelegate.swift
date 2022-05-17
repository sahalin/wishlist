// 
//  SceneDelegate.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window!.tintColor = Colors.tint
        window!.rootViewController = AppContainerVC(env: AppEnvironment())
        window!.makeKeyAndVisible()
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = Colors.tintAlerts
        UIView.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = Colors.tintNavigation
    }
}
