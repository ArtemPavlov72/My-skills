//
//  Contact.swift
//  My skills
//
//  Created by Artem Pavlov on 13.04.2022.
//

import RealmSwift

class Contact: Object {
    @objc dynamic let name = ""
    @objc dynamic let surname = ""
    var fullName: String {
        "(\(name) \(surname)"
    }
    let contactsData = List<ContactData>()
}

class ContactData: Object {
    @objc dynamic let phoneNumber = ""
    @objc dynamic let mail = ""
    @objc dynamic let adress = ""
    @objc dynamic let date = Date()
}
