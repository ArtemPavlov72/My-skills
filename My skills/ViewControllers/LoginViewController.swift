//
//  ViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 20.01.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var visitorNameTextField: UITextField!
    
    //MARK: - Private Properties
    private var visitorName = ""
    
    //первый цвет для градиента
    private let topColor = UIColor(
        red: 0/255,
        green: 150/255,
        blue: 180/255,
        alpha: 0.1
    )
    //второй цвет для градиента
    private let bottomColor = UIColor(
        red: 130/255,
        green: 0/255,
        blue: 150/255,
        alpha: 0.2
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: topColor, bottomColor: bottomColor)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else {return}
        guard let tabBarVC = navigationVC.topViewController as? TabBarViewController else {return}
        tabBarVC.visitor = visitorName
    }
    
    //MARK: - IBActions
    @IBAction func enterPressed() {
        guard let inputText = visitorNameTextField.text, !inputText.isEmpty else {
            showAlert(with: "Вы ничего не ввели..", and: "Пожалуйста, введите свое имя")
            return
        }
        if let _ = Double(inputText) {
            showAlert(with: "УУПС!", and: "Попробуйте ввести имя при помощи букв")
        }
        visitorName = visitorNameTextField.text ?? "888"
    }
}

//MARK: - Private Methods
extension LoginViewController {
    private func showAlert(with title: String, and massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in self.visitorNameTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

//MARK: - Set background color
//устанавливаем градиент для фона
extension UIView {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
