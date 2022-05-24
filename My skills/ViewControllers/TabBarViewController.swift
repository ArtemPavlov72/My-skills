//
//  TabBarViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 24.01.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: - Public Properties
    var visitor: Visitor!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        title = self.tabBar.selectedItem?.title
    }
    
    //Dynamic title for tabBar
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
    
    //MARK: - Private Methods
    private func setupViewControllers() {
        let projects = Project.allCases
        
        guard let projectsVC = viewControllers?.last as? ProjectsTableViewController else {return}
        guard let welcomeVC = viewControllers?.first as? WelcomeViewController else {return}
        
        welcomeVC.visitor = visitor
        projectsVC.projectList = projects
    }
}
    
