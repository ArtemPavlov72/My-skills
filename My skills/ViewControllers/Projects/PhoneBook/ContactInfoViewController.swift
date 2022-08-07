//
//  ContactInfoViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 21.04.2022.
//

import UIKit

class ContactInfoViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var contactNameTitle: UILabel!
    @IBOutlet weak var phoneNumberTitle: UILabel!
    @IBOutlet weak var mailTitle: UILabel!
    @IBOutlet weak var adressTitle: UILabel!
    
    //MARK: - Public Properties
    var contact: Contact!
    
    //MARK: - Life cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactInfo()
    }
    
    //MARK: - Private Methods
    private func getContactInfo() {
        contactNameTitle.text = contact.fullName
        mailTitle.text = !contact.mail.isEmpty ? ("Email: \(contact.mail)") : nil
        adressTitle.text = !contact.address.isEmpty ? ("Address: \(contact.address)") : nil
        
        let phoneNumber = formatPhoneNumber(for: contact.phoneNumber)
        phoneNumberTitle.text = !contact.phoneNumber.isEmpty ? ("Telefone: \(phoneNumber)") : nil
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
