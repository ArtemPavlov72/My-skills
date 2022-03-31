//
//  AlertController.swift
//  My skills
//
//  Created by Artem Pavlov on 27.03.2022.
//

import UIKit

extension UIAlertController {
    func action(taskList: TaskList?, completion: @escaping(String) -> Void) {
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let textValue = self.textFields?.first?.text else { return }
            guard !textValue.isEmpty else { return }
            completion(textValue)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Текст заметки"
            textField.text = taskList?.title
        }
    }
}
