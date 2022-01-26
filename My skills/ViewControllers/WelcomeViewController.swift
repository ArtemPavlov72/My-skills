//
//  WelcomViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 22.01.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    
    var visitor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.topViewController?.title = "Главный экран"
        welcomeLabel.text = "Привет, \(visitor)!"
    }
}
