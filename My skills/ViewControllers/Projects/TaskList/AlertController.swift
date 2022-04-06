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
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let textValue = self.textFields?.first?.text else { return }
            guard !textValue.isEmpty else { return }
            completion(textValue)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Введите название списка"
            textField.text = taskList?.title
        }
    }
    
    func taskAction(task: Task?, completion: @escaping(String, String) -> Void) {
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let textValue = self.textFields?.first?.text else { return }
            guard !textValue.isEmpty else { return }
            
            if let note = self.textFields?.last?.text, !note.isEmpty {
                completion(textValue, note)
            } else {
                completion(textValue, "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Введите название заметки"
            textField.text = task?.title
        }
        addTextField { textField in
            textField.placeholder = "Введите текст заметки"
            textField.text = task?.note
        }
    }
}
