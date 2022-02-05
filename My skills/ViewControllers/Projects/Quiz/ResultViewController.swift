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
        updateResult()
    }
    
    private func updateResult() {
        let mostFrequencyFamiliarity = Dictionary(grouping: answers) { $0.degreeOfFamiliarity }
            .sorted { $0.value.count > $1.value.count }
            .first?.key
        
        updateUI(with: mostFrequencyFamiliarity)
    }
    
    private func updateUI(with familiarity: Familiarity?) {
        resultLabelText.text = "Мы - \(familiarity?.rawValue ?? "")!"
        resultLabelDescription.text = familiarity?.definition ?? ""
    }
    
}
