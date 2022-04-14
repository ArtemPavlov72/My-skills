//
//  PhoneBookTableViewController.swift
//  My skills
//
//  Created by admin  on 13.04.2022.
//

import UIKit

class PhoneBookTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return 0
    }


}
