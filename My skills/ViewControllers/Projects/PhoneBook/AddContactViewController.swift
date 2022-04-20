//
//  AddContactViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 16.04.2022.
//

import UIKit
import RealmSwift

class AddContactViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    
    //MARK: - Private Properties
    private var sections: Results<SectionTitleForContact>!
    private var contacts: Results<Contact>!
    private var createNew = true
    
    //MARK: - Public Properties
    var delegate: PhoneBookTableViewControllerDelegate?
    
    //MARK: - Life cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRealm()
    }
    
    //MARK: - IB Actions
    @IBAction func saveButton() {
        saveNewContact()
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
    
    //MARK: - Private Methods
    private func loadRealm() {
        sections = StorageManagerRealm.shared.realm.objects(SectionTitleForContact.self)
        contacts = StorageManagerRealm.shared.realm.objects(Contact.self)
    }
    
    private func createNewContact() -> Contact {
        let newContact = Contact()
        newContact.name = nameTextField.text ?? ""
        newContact.surname = secondNameTextField.text ?? ""
        newContact.phoneNumber = phoneNumberTextField.text ?? ""
        newContact.mail = mailTextField.text ?? ""
        newContact.adress = adressTextField.text ?? ""
        return newContact
    }
    
    private func setSectionTitle(for contact: Contact) -> String {
        let sectionTitleForNewContact = String(contact.surname.prefix(1).capitalized)
        return sectionTitleForNewContact
    }
    
    private func updateSectionTitle(for contact: Contact, in sectionTitle: String) {
        for sectionName in sections {
            if sectionName.title == sectionTitle {
                StorageManagerRealm.shared.save(contact, to: sectionName)
                createNew.toggle()
            }
        }
    }
    
    private func createSectionTitle(for contact: Contact, with sectionTitle: String) {
        if createNew {
            let sectionTitleForNewContact = SectionTitleForContact()
            sectionTitleForNewContact.title = sectionTitle
            sectionTitleForNewContact.containsContacts.append(contact)
            StorageManagerRealm.shared.save(sectionTitleForNewContact)
        }
    }
    
    private func saveNewContact() {
        let newContact = createNewContact()
        guard !newContact.name.isEmpty else { return }
        guard !newContact.surname.isEmpty else { return }
        
        let sectionTitle = setSectionTitle(for: newContact)
        updateSectionTitle(for: newContact, in: sectionTitle)
        createSectionTitle(for: newContact, with: sectionTitle)
        
        delegate?.reloadRealmData()
        dismiss(animated: true)
    }
}
