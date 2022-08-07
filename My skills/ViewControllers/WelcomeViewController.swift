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
        getWelcomeInfo()
    }
    
    override func viewWillLayoutSubviews() {
        developerPhoto.layer.cornerRadius = developerPhoto.frame.width / 2
    }
    
    private func getWelcomeInfo() {
        welcomeLabel.text = "Hi, \(visitor.name.capitalized)👋"
        developerPhoto.image = UIImage(named: "pavlov_artem")
        welcomeTextLabel.text = "My name is Artem, and i'm glad to see you in my test app 👨🏻‍🏫... On the next tab you will find some of my projects😇"
    }
}
