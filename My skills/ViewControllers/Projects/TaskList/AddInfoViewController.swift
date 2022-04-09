//
//  AddInfoViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 24.03.2022.
//

import UIKit
import CoreData

class AddInfoViewController: UIViewController {
    
    //MARK: - Private Properties
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Новый список"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 200/255, blue: 150/255, alpha: 1)
        button.setTitle("Cохранить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 200/255, green: 80/255, blue: 20/255, alpha: 1)
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Public Properties
    var delegate: TaskListViewControllerDelegate?
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 1)
        setupSubviews(taskTextField, saveButton, cancelButton)
        setupConstraints()
    }
    
    //MARK: - Private Methods
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    @objc private func saveAction() {
        self.saveButton.pulsate()
        guard let inputText = taskTextField.text, !inputText.isEmpty else { return }
        StorageManager.shared.saveTasklist(nameOfTaskList: inputText)
        delegate?.reloadTaskLists()
        dismiss(animated: true)
    }
    
    @objc private func cancelAction() {
        self.cancelButton.pulsate()
        dismiss(animated: true)
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 70),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }
}
