//
//  AlertController.swift
//  My skills
//
//  Created by Artem Pavlov on 27.03.2022.
//

import UIKit

extension UIAlertController {
    
    static func createAlert(withTitle title: String, andMessage message: String) -> UIAlertController {
        UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func taskListAction(taskList: TaskList?, completion: @escaping(String) -> Void) {
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textValue = self.textFields?.first?.text else { return }
            guard !textValue.isEmpty else { return }
            completion(textValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Enter list name"
            textField.text = taskList?.title
        }
    }
    
    func taskAction(task: TaskCD?, completion: @escaping(String, String) -> Void) {
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textValue = self.textFields?.first?.text else { return }
            guard !textValue.isEmpty else { return }
            
            if let note = self.textFields?.last?.text, !note.isEmpty {
                completion(textValue, note)
            } else {
                completion(textValue, "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Enter note title"
            textField.text = task?.title
        }
        addTextField { textField in
            textField.placeholder = "Enter note text"
            textField.text = task?.note
        }
    }
}
