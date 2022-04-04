//
//  TaskListViewController.swift
//  My skills
//
//  Created by admin  on 31.03.2022.
//


import UIKit
import CoreData

protocol TaskTableViewControllerDelegate {
    func reloadTasks()
}


class TaskTableViewController: UITableViewController {
    
    //MARK: - Private Properties
    
    private let cellID = "cell"
    private var tasks: [Task] = []
    
    var taskList: TaskList!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        tasks = taskList.tasks?.allObjects as? [Task] ?? []
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let task = tasks[indexPath.row]
        
        content.text = task.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = taskList.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addAction)
        )
    }
    
    @objc private func addAction() {
        let AddTaskVC = AddTaskViewController()
        AddTaskVC.delegate = self
        AddTaskVC.taskList = taskList
        present(AddTaskVC, animated: true)
    }

}

//MARK: - Delegate Tasks
extension TaskTableViewController: TaskTableViewControllerDelegate {
    func reloadTasks() {
       
        tableView.reloadData()
    }
}

