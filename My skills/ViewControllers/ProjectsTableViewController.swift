//
//  ProjectsTableViewController.swift
//  My skills
//
//  Created by iMac on 26.01.2022.
//

import UIKit

class ProjectsTableViewController: UITableViewController {
    
    var projectList: [Project] = []
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projectList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let project = projectList[indexPath.row]
        
        content.text = project.fullDescription
        cell.contentConfiguration = content
        
        return cell
    }
    
}
