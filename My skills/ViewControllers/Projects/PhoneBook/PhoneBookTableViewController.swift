//
//  PhoneBookTableViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 13.04.2022.
//

import RealmSwift
import UIKit

protocol PhoneBookTableViewControllerDelegate {
    func reloadRealmData()
}

class PhoneBookTableViewController: UITableViewController {
    
    //MARK: - Private Properties
    private var sections: Results<SectionTitleForContact>!
    private var contacts: Results<Contact>!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getTestData()
        loadRealm()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].containsContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contacts = sections[indexPath.section]
        let contact = contacts.containsContacts[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = contact.fullName
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contactsSection = sections[indexPath.section]
        let contact = contactsSection.containsContacts[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            StorageManagerRealm.shared.delete(contact)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if contactsSection.containsContacts.isEmpty {
                StorageManagerRealm.shared.delete(contactsSection)
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
        }
        
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addContactVC = segue.destination as? AddContactViewController else {return}
        addContactVC.delegate = self
    }
    
    //MARK: - IB Actions
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    //MARK: - Private Methods
    private func getTestData() {
        DataManager.shared.createContactData {
            self.tableView.reloadData()
        }
    }
    
    private func loadRealm() {
        sections = StorageManagerRealm.shared.realm.objects(SectionTitleForContact.self)
        contacts = StorageManagerRealm.shared.realm.objects(Contact.self)
    }
}
//MARK: - DelegateNewContact
extension PhoneBookTableViewController: PhoneBookTableViewControllerDelegate {
    func reloadRealmData() {
        loadRealm()
        tableView.reloadData()
    }
}
