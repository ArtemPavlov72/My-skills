//
//  ProjectsTableViewController.swift
//  My skills
//
//  Created by iMac on 26.01.2022.
//

import UIKit

class ProjectsTableViewController: UITableViewController {
    
    //MARK: - Public Properties
    var projectList: [Project] = []
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        projectList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let project = projectList[indexPath.row]
        
        content.text = project.rawValue
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentProject = projectList[indexPath.row]
        
        switch currentProject {
            
        case .trafficLights:
            performSegue(withIdentifier: "showTrafficLights", sender: nil)
        case .quiz:
            performSegue(withIdentifier: "showQuiz", sender: nil)
        case .colorMix:
            performSegue(withIdentifier: "colorMix", sender: nil)
        }
    }
    
}
