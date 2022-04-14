//
//  PhoneBookTableViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 13.04.2022.
//

import RealmSwift
import UIKit

class PhoneBookTableViewController: UITableViewController {

    //MARK: - Private Properties
    private var contacts: Results<Contact>!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getTestData()
        contacts = StorageManagerRealm.shared.realm.objects(Contact.self)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contacts[section].fullName
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let contact = contacts[indexPath.section]
        let contactInfo = contact.contactsData
        var content = cell.defaultContentConfiguration()
        
     
            
        
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    //MARK: - IB Actions
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }

    //MARK: - Private Methods
    private func getTestData() {
        DataManager.shared.createContactData {
            self.tableView.reloadData()
        }
    }
}
