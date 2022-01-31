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
    
    //MARK: - Public Properties
    var visitor = ""
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Привет, \(visitor)!"
        welcomeTextLabel.text = "Меня зовут Артем, и это мое тестовое приложение, где я пробую новые скилы в разработке SWIFT 👨🏻‍🏫... В общем, чувствуй себя, как дома! На следующей вкладке, ты найдешь разные проекты - это либо ДЗ от курсов Swiftbook, либо какие-то заинтересовавшие меня проекты на просторах гугла..🤓"
    }
}
