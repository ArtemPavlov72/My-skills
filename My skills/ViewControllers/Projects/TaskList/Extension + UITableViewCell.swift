//
//  Extension + UITableViewCell.swift
//  My skills
//
//  Created by admin  on 07.04.2022.
//

import UIKit

extension UITableViewCell {
    func configure(with taskList: TaskList) {
        guard let currentTasks = taskList.tasks?.allObjects as? [Task] else {return}
   /*     for i in currentTasks {
            if i.isComplete == false {
           }
        }
        currentTasks.filter({ task in
            task.isComplete
        }) */
        
        var content = defaultContentConfiguration()
        content.text = taskList.title
        
        if currentTasks.isEmpty {
            content.secondaryText = "0"
        } else {
            content.secondaryText = "\(currentTasks.count)"
            accessoryType = .none
        }
        contentConfiguration = content
    }
}


