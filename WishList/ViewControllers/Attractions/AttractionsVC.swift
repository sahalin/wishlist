// 
//  AttractionsVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class AttractionsVC: WLViewController {
    init(env: AppEnvironment) {
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Strings.attractionsTitle
        view.backgroundColor = .systemBackground
    }
}
