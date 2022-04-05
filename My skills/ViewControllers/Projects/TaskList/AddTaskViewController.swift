//
//  AddTaskViewController.swift
//  My skills
//
//  Created by Artem Pavlov  on 03.04.2022.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    //MARK: - Private Properties
    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Новая задача"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var taskNoteTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Описание задачи"
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
    var delegate: TaskTableViewControllerDelegate?
    var taskList: TaskList!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 230/255, alpha: 1)
        setupSubviews(taskTextField, taskNoteTextField, saveButton, cancelButton)
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
        let inputNoteText = taskNoteTextField.text ?? ""
        StorageManager.shared.saveTask(inputText, note: inputNoteText, to: taskList)
        delegate?.reloadTasks()
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
        
        taskNoteTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskNoteTextField.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 30),
            taskNoteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            taskNoteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskNoteTextField.bottomAnchor, constant: 70),
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
