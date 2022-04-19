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
        
        let newContact = Contact()
        
        guard let inputTextName = nameTextField.text, !inputTextName.isEmpty else { return }
        newContact.name = inputTextName
        
        guard let inputSurnameText = secondNameTextField.text, !inputSurnameText.isEmpty else { return }
        newContact.surname = inputSurnameText
        
        let inputPhoneText = inputText(from: phoneNumberTextField)
        newContact.phoneNumber = inputPhoneText
        
        
        let inputMailText = inputText(from: mailTextField)
        newContact.mail = inputMailText
        
        let inputAdressText = inputText(from: adressTextField)
        newContact.adress = inputAdressText
        
        let sectionTitleForNewContact = String(newContact.surname.prefix(1).capitalized)
        
        for sectionName in sections {
            if sectionName.title == sectionTitleForNewContact {
                StorageManagerRealm.shared.save(newContact, to: sectionName)
                createNew.toggle()
                delegate?.reloadRealmData()
            }
        }
        
        if createNew {
            let sectionTitleOfNewContact = SectionTitleForContact()
            sectionTitleOfNewContact.title = sectionTitleForNewContact
            sectionTitleOfNewContact.containsContacts.append(newContact)
            StorageManagerRealm.shared.save(sectionTitleOfNewContact)
            delegate?.reloadRealmData()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
    
    //MARK: - Private Methods
    private func loadRealm() {
        sections = StorageManagerRealm.shared.realm.objects(SectionTitleForContact.self)
        contacts = StorageManagerRealm.shared.realm.objects(Contact.self)
    }
    
    private func inputText(from text: UITextField) -> String {
        guard let inputText = text.text, !inputText.isEmpty else { return "" }
        return inputText
    }
}
