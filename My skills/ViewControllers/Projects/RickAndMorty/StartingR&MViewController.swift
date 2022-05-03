//
//  StaringR&MViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 11.03.2022.
//

import UIKit

class StartingRMViewController: UIViewController {
    
    // MARK: - Private Properties
    private var fetchingMethod = FetchingMethod.automatic
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else {return}
        guard let mainVC = navigationVC.topViewController as? CharactersListController else {return}
        mainVC.fetchingMethod = fetchingMethod
    }
    
    // MARK: - IB Actions
    @IBAction func pressButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            perfomSegueUsing(FetchingMethod.automatic)
        case 2:
            perfomSegueUsing(FetchingMethod.withAlamofire)
        case 3:
            perfomSegueUsing(FetchingMethod.withCache)
        default:
            perfomSegueUsing(FetchingMethod.withAsyncAwait)
        }
    }
    
    // MARK: - private methods
    private func perfomSegueUsing(_ method: FetchingMethod) {
        fetchingMethod = method
        performSegue(withIdentifier: "startRickAndMorty", sender: nil)
    }
}
