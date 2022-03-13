//
//  StaringR&MViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 11.03.2022.
//

import UIKit

class StartingRMViewController: UIViewController {
    
    // MARK: - Private Properties
    private var automaticFetch = true
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else {return}
        guard let mainVC = navigationVC.topViewController as? CharactersListController else {return}
        mainVC.automaticFetch = automaticFetch
    }
    
    // MARK: - IB Actions
    @IBAction func pressButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            perfomSegueWithAutomaticFetch(true)
        default:
            perfomSegueWithAutomaticFetch(false)
        }
    }
    
    // MARK: - private methods
    private func perfomSegueWithAutomaticFetch(_ type: Bool) {
        automaticFetch = type
        performSegue(withIdentifier: "startRickAndMorty", sender: nil)
    }
}
