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
        phoneNumberTitle.text = !contact.phoneNumber.isEmpty ? ("Телефон: \(contact.phoneNumber)") : nil
        mailTitle.text = !contact.mail.isEmpty ? ("Почта: \(contact.mail)") : nil
        adressTitle.text = !contact.adress.isEmpty ? ("Адрес: \(contact.adress)") : nil
    }
}
