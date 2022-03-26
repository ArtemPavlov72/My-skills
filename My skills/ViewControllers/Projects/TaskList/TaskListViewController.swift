//
//  TaskListViewController.swift
//  My skills
//
//  Created by Artem Pavlov  on 23.03.2022.
//

import UIKit
import CoreData

protocol TaskListViewControllerDelegate {
    
}

class TaskListViewController: UITableViewController {
    
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

extension TaskListViewController: TaskListViewControllerDelegate {
    
}
