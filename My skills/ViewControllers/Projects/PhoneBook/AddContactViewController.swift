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
    @IBOutlet weak var addressTextField: UITextField!
    
    //MARK: - Private Properties
    private var sections: Results<SectionTitleForContact>!
    private var createNew = true
    
    //MARK: - Public Properties
    var delegate: PhoneBookTableViewControllerDelegate?
    var additingContact: Contact?
    
    //MARK: - Life cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRealm()
        loadContactInfoForEdit()
    }
    
    //MARK: - IB Actions
    @IBAction func saveButton() {
        saveContact()
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
    
    //MARK: - Private Methods
    private func loadRealm() {
        sections = StorageManagerRealm.shared.realm.objects(SectionTitleForContact.self)
    }
    
    private func loadContactInfoForEdit() {
        nameTextField.text = additingContact?.name
        secondNameTextField.text = additingContact?.surname
        phoneNumberTextField.text = additingContact?.phoneNumber
        mailTextField.text = additingContact?.mail
        addressTextField.text = additingContact?.address
    }
    
    private func createContact() -> Contact {
        let contact = Contact()
        
        contact.name = nameTextField.text ?? ""
        contact.surname = secondNameTextField.text ?? ""
        if let _ = Double(phoneNumberTextField.text ?? "") {
            contact.phoneNumber = phoneNumberTextField.text ?? ""
        }
        contact.mail = mailTextField.text ?? ""
        contact.address = addressTextField.text ?? ""
        return contact
    }
    
    private func setSectionTitle(for contact: Contact) -> String {
        var sectionTitleForContact = String(contact.surname.prefix(1).capitalized)
        if let _ = Double(sectionTitleForContact) {
            sectionTitleForContact = "#"
        }
        return sectionTitleForContact
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
    
    private func removeAditingContact() {
        guard let contactForRemove = additingContact else { return }
        let sectionTitleOfRemovingContact = setSectionTitle(for: contactForRemove)
        StorageManagerRealm.shared.delete(contactForRemove)
        for section in sections {
            if section.title == sectionTitleOfRemovingContact, section.containsContacts.isEmpty {
                StorageManagerRealm.shared.delete(section)
            }
        }
    }
    
    private func saveContact() {
        let contact = createContact()
        guard !contact.name.isEmpty else { return }
        guard !contact.surname.isEmpty else { return }
        
        let sectionTitle = setSectionTitle(for: contact)
        updateSectionTitle(for: contact, in: sectionTitle)
        createSectionTitle(for: contact, with: sectionTitle)
        
        if additingContact != nil {
            removeAditingContact()
        }
        delegate?.reloadRealmData()
        dismiss(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            guard let currentString = textField.text as? NSString else { return false}
            let newString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 10
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            secondNameTextField.becomeFirstResponder()
        case secondNameTextField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            mailTextField.becomeFirstResponder()
        case mailTextField:
            addressTextField.becomeFirstResponder()
        default:
            saveButton()
        }
        return true
    }
}


