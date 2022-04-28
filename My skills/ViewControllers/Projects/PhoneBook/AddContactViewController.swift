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
    //private var contacts: Results<Contact>!
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
        //      contacts = StorageManagerRealm.shared.realm.objects(Contact.self)
    }
    
    private func loadContactInfoForEdit() {
        nameTextField.text = additingContact?.name
        secondNameTextField.text = additingContact?.surname
        phoneNumberTextField.text = additingContact?.phoneNumber
        mailTextField.text = additingContact?.mail
        adressTextField.text = additingContact?.adress
    }
    
    private func createContact() -> Contact {
        let contact = Contact()
        
        contact.name = nameTextField.text ?? ""
        contact.surname = secondNameTextField.text ?? ""
        contact.phoneNumber = formatPhoneNumber(for: phoneNumberTextField.text ?? "")
        contact.mail = mailTextField.text ?? ""
        contact.adress = adressTextField.text ?? ""
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
    
    private func formatPhoneNumber(for number: String) -> String {
        let phoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+7 (XXX) XXX-XXXX"
        var phoneNumberInMask = ""
        var index = phoneNumber.startIndex
        
        for character in mask where index < phoneNumber.endIndex {
            if character == "X" {
                phoneNumberInMask.append(phoneNumber[index])
                index = phoneNumber.index(after: index)
            } else {
                phoneNumberInMask.append(character)
            }
        }
        return phoneNumberInMask
    }
}

//MARK: - UITextFieldDelegate
extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formatPhoneNumber(for: newString)
        return false
    }
}


