//
//  TaskListViewController.swift
//  My skills
//
//  Created by Artem Pavlov  on 23.03.2022.
//

import UIKit
import CoreData

protocol TaskListViewControllerDelegate {
    func reloadTasks()
}

class TaskListViewController: UITableViewController {
    
    //MARK: - Private Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let cellID = "cell"
    private var tasks: [Task] = []
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        fetchData()
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
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Список задач"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addAction)
        )
    }
    
    @objc private func addAction() {
        let newTaskVC = NewTaskViewController()
        newTaskVC.delegate = self
        present(newTaskVC, animated: true)
    }
    
    private func fetchData() {
        let fetchRequest = Task.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        }
        catch let error {
            print("Failed to fetch data", error)
        }
    }
}

// MARK: - Delegate Tasks
extension TaskListViewController: TaskListViewControllerDelegate {
    func reloadTasks() {
        fetchData()
        tableView.reloadData()
    }
}
