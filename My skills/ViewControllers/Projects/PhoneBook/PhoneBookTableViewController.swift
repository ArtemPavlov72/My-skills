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
        let contact = getFilteredContactIndexPath(indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = contact.fullName
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contactsSection = sections[indexPath.section]
        let contact = contactsSection.containsContacts.sorted(byKeyPath: "surname", ascending: true)[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            StorageManagerRealm.shared.delete(contact)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if contactsSection.containsContacts.isEmpty {
                StorageManagerRealm.shared.delete(contactsSection)
                tableView.deleteSections([indexPath.section], with: .automatic)
            }
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Редактировать") { _, _, isDone in
            self.performSegue(withIdentifier: "addCell", sender: indexPath)
            isDone(true)
        }
        
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCell" {
            guard let addContactVC = segue.destination as? AddContactViewController else {return}
            addContactVC.delegate = self
            if let indexPath = sender as? IndexPath {
                let contact = getFilteredContactIndexPath(indexPath)
                addContactVC.additingContact = contact
            }
        } else {
            guard let contactVC = segue.destination as? ContactInfoViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let contact = getFilteredContactIndexPath(indexPath)
            contactVC.contact = contact
        }
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
        sections = StorageManagerRealm.shared.realm.objects(SectionTitleForContact.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    private func getFilteredContactIndexPath(_ indexPath: IndexPath) -> Contact {
        let contactsSection = sections[indexPath.section]
        let contact = contactsSection.containsContacts.sorted(byKeyPath: "surname", ascending: true)[indexPath.row]
        return contact
    }
}

//MARK: - DelegateNewContact
extension PhoneBookTableViewController: PhoneBookTableViewControllerDelegate {
    func reloadRealmData() {
        loadRealm()
        tableView.reloadData()
    }
}
