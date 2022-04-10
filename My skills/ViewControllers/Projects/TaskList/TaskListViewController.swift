//
//  TaskListViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 31.03.2022.
//

import UIKit
import CoreData

protocol TaskTableViewControllerDelegate {
    func reloadTasks()
}

class TaskTableViewController: UITableViewController {
    
    //MARK: - Private Properties
    private let cellID = "cell"
    private var currentTasks: [Task] = []
    private var completedTasks: [Task] = []
    
    
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Текущие задачи" : "Завершенные задачи"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        content.secondaryText = task.note
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Удалить") { _, _, _ in
            if indexPath.section == 0 {
                self.currentTasks.remove(at: indexPath.row)
            } else {
                self.completedTasks.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteTask(task)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Редактировать") { _, _, isDone in
            self.showAlert(task: task) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        let doneButtonTitle = indexPath.section == 0 ? "Завершить" : "Восстановить"
        
        let doneAction = UIContextualAction(style: .normal, title: doneButtonTitle) { _, _, isDone in
            
            if indexPath.section == 0 {
                let movableTask = self.currentTasks.remove(at: indexPath.row)
                self.completedTasks.append(movableTask)
            } else {
                let movableTask = self.completedTasks.remove(at: indexPath.row)
                self.currentTasks.append(movableTask)
            }
            
            StorageManager.shared.addDoneFor(task)
            
            let indexPathForCurrentTask = IndexPath(row: self.currentTasks.count - 1, section: 0)
            let indexPathForCompletedTask = IndexPath(row: self.completedTasks.count - 1, section: 1)
            let destinationIndex = indexPath.section == 0 ? indexPathForCompletedTask : indexPathForCurrentTask
            tableView.moveRow(at: indexPath, to: destinationIndex)
            
            isDone(true)
        }
        
        editAction.backgroundColor = .orange
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [doneAction, deleteAction, editAction])
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
        guard let taskLists = taskList.tasks?.allObjects as? [Task] else {return}
        currentTasks = taskLists.filter({ task in
            task.isComplete == false
        })
        completedTasks = taskLists.filter({ task in
            task.isComplete == true
        })
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
    private func showAlert(task: Task?, completion: (() -> Void)?) {
        let alert = UIAlertController.createAlert(withTitle: "Редактируем название заметки", andMessage: "Введите новое название")
        
        alert.taskAction(task: task) { newValue, note in
            if let task = task, let completion = completion {
                StorageManager.shared.editTask(task, withNewName: newValue, andNote: note)
                completion()
            }
        }
        present(alert, animated: true)
    }
}

