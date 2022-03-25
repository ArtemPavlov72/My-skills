//
//  TaskListViewController.swift
//  My skills
//
//  Created by Artem Pavlov  on 23.03.2022.
//

import UIKit

class TaskListViewController: UITableViewController {

    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "Список задач "
        
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
}
