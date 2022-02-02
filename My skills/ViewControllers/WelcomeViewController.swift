//
//  WelcomViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 22.01.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var welcomeTextLabel: UILabel!
    @IBOutlet var developerPhoto: UIImageView!
    
    
    //MARK: - Public Properties
    var visitor: Visitor!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Привет, \(visitor.name)👋"
        developerPhoto.image = UIImage(named: "pavlov_artem")
        welcomeTextLabel.text = "Меня зовут Артем, и это мое тестовое приложение, где я пробую новые скилы в разработке SWIFT 👨🏻‍🏫... На следующей вкладке ты найдешь некоторые мои проекты 😇"
    }
    
    override func viewWillLayoutSubviews() {
        developerPhoto.layer.cornerRadius = developerPhoto.frame.width / 2
    }
}
