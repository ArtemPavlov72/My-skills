//
//  NewTaskViewController.swift
//  My skills
//
//  Created by admin  on 24.03.2022.
//

import UIKit

class NewTaskViewController: UIViewController {

    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Новая задача "
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0/255, green: 200/255, blue: 20/255, alpha: 1)
        button.setTitle("Cохранить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 220/255, green: 50/255, blue: 20/255, alpha: 1)
        button.setTitle("Отмена", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(taskTextField, saveButton, cancelButton)
        setupConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
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
    
    @objc private func saveAction() {
        dismiss(animated: true)
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }

}
