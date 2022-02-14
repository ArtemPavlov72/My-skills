//
//  Extension + UIButton.swift
//  My skills
//
//  Created by iMac on 14.02.2022.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.initialVelocity = 0.7
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }
}
// 
