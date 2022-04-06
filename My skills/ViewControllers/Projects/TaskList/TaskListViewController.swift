//
//  TaskListViewController.swift
//  My skills
//
//  Created by Artem Pavlov  on 31.03.2022.
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
    
    //MARK: - Public Properties
    var taskList: TaskList!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerCell()
        setupNavigationBar()
        loadTasks()
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
        content.secondaryText = task.note
        cell.contentConfiguration = content
        
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = tasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Удалить") { _, _, _ in
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteTask(task)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Редактировать") { _, _, isDone in
            
        }
        
        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
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
    
    private func loadTasks() {
        tasks = taskList.tasks?.allObjects as? [Task] ?? []
    }
    
    private func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

//MARK: - Delegate Tasks
extension TaskTableViewController: TaskTableViewControllerDelegate {
    func reloadTasks() {
        loadTasks()
        tableView.reloadData()
    }
}

//MARK: - Alert Controller
extension TaskTableViewController {
    
}

