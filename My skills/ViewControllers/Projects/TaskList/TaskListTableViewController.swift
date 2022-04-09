//
//  TaskListViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 23.03.2022.
//

import UIKit
import CoreData

protocol TaskListViewControllerDelegate {
    func reloadTaskLists()
}

class TaskListTableViewController: UITableViewController {
    
    //MARK: - Private Properties
    private let cellID = "cell"
    private var taskLists: [TaskList] = []
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        registerCell()
        setupNavigationBar()
        fetchTaskLists()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let cell = UITableViewCell(style: .value2, reuseIdentifier: cellID)
        //var content = cell.defaultContentConfiguration()
        let taskList = taskLists[indexPath.row]
        cell.configure(with: taskList)
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskList = taskLists[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            self.taskLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteTaskList(taskList)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Редактировать") { _, _, isDone in
            self.showAlert(taskList: taskList) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let taskList = taskLists[indexPath.row]
        let taskVC = TaskTableViewController()
        taskVC.taskList = taskList
        show(taskVC, sender: nil)
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Списки задач"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addAction)
        )
    }
    
    @objc private func addAction() {
        let AddInfoVC = AddInfoViewController()
        AddInfoVC.delegate = self
        present(AddInfoVC, animated: true)
    }
    
    private func fetchTaskLists() {
        StorageManager.shared.fetchTaskList { result in
            switch result {
            case .success(let taskLists):
                self.taskLists = taskLists
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func registerCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

//MARK: - Delegate Tasks
extension TaskListTableViewController: TaskListViewControllerDelegate {
    func reloadTaskLists() {
        fetchTaskLists()
        tableView.reloadData()
    }
}

//MARK: - Alert Controller
extension TaskListTableViewController {
    private func showAlert(taskList: TaskList?, completion: (() -> Void)?) {
        let alert = UIAlertController.createAlert(withTitle: "Редактируем название списка", andMessage: "Введите новое название")
        
        alert.taskListAction(taskList: taskList) { taskName in
            if let taskList = taskList, let completion = completion {
                StorageManager.shared.editTaskList(taskList, newTaskListName: taskName)
                completion()
            }
        }
        present(alert, animated: true)
    }
}
