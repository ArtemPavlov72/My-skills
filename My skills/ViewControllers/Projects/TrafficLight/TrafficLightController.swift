//
//  TrafficLightController.swift
//  My skills
//
//  Created by Artem Pavlov on 31.01.2022.
//

import UIKit

class TrafficLightController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var redLight: UIView!
    @IBOutlet var yellowLight: UIView!
    @IBOutlet var greenLight: UIView!
    @IBOutlet var startButton: UIButton!
    
    // MARK: - Private Properties
    private var currentLight = CurrentLight.red
    private var lightIsOn: CGFloat = 1
    private var lightIsOff: CGFloat = 0.2
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.cornerRadius = 25
        
        redLight.alpha = lightIsOff
        yellowLight.alpha = lightIsOff
        greenLight.alpha = lightIsOff
    }
    
    override func viewWillLayoutSubviews() {
        redLight.layer.cornerRadius = redLight.frame.width / 2
        yellowLight.layer.cornerRadius = yellowLight.frame.width / 2
        greenLight.layer.cornerRadius = greenLight.frame.width / 2
    }
    
    // MARK: - IB Actions
    @IBAction func startButtonPressed(_ sender: UIButton) {
        sender.pulsate()
        if startButton.currentTitle == "НАЧАТЬ" {
            startButton.setTitle("ДАЛЬШЕ", for: .normal)
        }
        
        switch currentLight {
        case .red:
            redLight.alpha = lightIsOn
            greenLight.alpha = lightIsOff
            currentLight = .yellow
        case .yellow:
            redLight.alpha = lightIsOff
            yellowLight.alpha = lightIsOn
            currentLight = .green
        case .green:
            yellowLight.alpha = lightIsOff
            greenLight.alpha = lightIsOn
            currentLight = .red
        }
    }
} 

// MARK: - Set Enum For Lights
extension TrafficLightController {
    enum CurrentLight {
        case red, yellow, green
    }
}
