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
    
    //MARK: - Dynamic title for tabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.tabBar.selectedItem?.title
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
    
    //MARK: - Private Methods
    private func setupViewControllers() {
        let projects = Project.getProjectsList()
        
        guard let projectsVC = viewControllers?.last as? ProjectsTableViewController else {return}
        guard let welcomeVC = viewControllers?.first as? WelcomeViewController else {return}
        
        welcomeVC.visitor = visitor
        projectsVC.projectList = projects
    }
}
    
