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

class TaskListTableViewController: UITableViewController {
    
    //MARK: - Private Properties
    
    private let cellID = "cell"
    private var taskLists: [TaskList] = []
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        fetchTasks()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let task = taskLists[indexPath.row]
        
        content.text = task.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    //MARK: - Table View Delegate
 /*   override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        tableView.deselectRow(at: indexPath, animated: true)
        let taskList = taskLists[indexPath.row]
        
      //  let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
        //    self.taskLists.remove(at: indexPath.row)
        //    tableView.deleteRows(at: [indexPath], with: .automatic)
        //    StorageManager.shared.deleteData(taskList)
      //  }
        
  //      let editAction = UIContextualAction(style: .normal, title: "Редактировать") { _, _, isDone in
   //         self.showAlert(task: task) {
    //            tableView.reloadRows(at: [indexPath], with: .automatic)
    //        }
        }
     //   editAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    } */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let task = taskLists[indexPath.row]
        showAlert(task: taskLists) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
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
        let newTaskVC = NewTaskViewController()
        newTaskVC.delegate = self
        present(newTaskVC, animated: true)
    }
    
    private func fetchTasks() {
        StorageManager.shared.fetchTaskList { result in
            switch result {
            case .success(let taskLists):
                self.taskLists = taskLists
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Delegate Tasks
extension TaskListTableViewController: TaskListViewControllerDelegate {
    func reloadTasks() {
        fetchTasks()
        tableView.reloadData()
    }
}

//MARK: - Alert Controller
extension TaskListTableViewController {
    private func showAlert(task: TaskList?, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "Редактируем заметку", message: "Введите новое название", preferredStyle: .alert)
        alert.action(taskList: task) { taskName in
            if let task = task, let completion = completion {
                StorageManager.shared.editData(taskList, newTask: taskName)
                completion()
            }
        }
        present(alert, animated: true)
    }
}
