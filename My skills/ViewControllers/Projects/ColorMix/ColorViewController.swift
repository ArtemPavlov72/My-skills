//
//  ColorViewController.swift
//  My skills
//
//  Created by iMac on 07.02.2022.
//

import UIKit

protocol ColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class ColorViewController: UIViewController {
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColorButton()
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorMixVC = segue.destination as? ColorMixViewController else {return}
        colorMixVC.delegate = self
        colorMixVC.viewColor = view.backgroundColor
    }
    
    // MARK: - Private Methods
    private func changeColorButton() {
        let changeButton = UIBarButtonItem(
            title: "Редактировать",
            style: .plain,
            target: self,
            action: #selector(changeColorButtonAction)
        )
        navigationItem.rightBarButtonItem = changeButton
    }
    
    @objc private func changeColorButtonAction() {
        performSegue(withIdentifier: "changeColor", sender: nil)
    }
}

// MARK: - Delegate New Color
extension ColorViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
