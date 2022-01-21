//
//  ViewController.swift
//  My skills
//
//  Created by iMac on 20.01.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    //первый цвет для градиента
    private let topColor = UIColor(
        red: 210/255,
        green: 109/255,
        blue: 128/255,
        alpha: 1
    )
    //второй цвет для градиента
    private let bottomColor = UIColor(
        red: 107/255,
        green: 148/255,
        blue: 220/255,
        alpha: 1
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: topColor, bottomColor: bottomColor)
    }
}

//устанавливаем градиент для фона
//MARK: - Set background color
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
