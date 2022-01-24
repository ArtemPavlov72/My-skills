//
//  TabBarViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 24.01.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var visitor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        guard let welcomeVC = viewControllers?.first as? WelcomeViewController else {return}
        
        welcomeVC.visitor = visitor
    }
}
    
