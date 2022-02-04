//
//  ResultViewController.swift
//  My skills
//
//  Created by iMac on 04.02.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var resultLabelText: UILabel!
    @IBOutlet var resultLabelDescription: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
    }
    
}
