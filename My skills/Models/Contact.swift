//
//  Contact.swift
//  My skills
//
//  Created by Artem Pavlov on 13.04.2022.
//

import RealmSwift

class Contact: Object {
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    var fullName: String {
        "(\(name) \(surname)"
    }
    let contactsData = List<ContactData>()
}

class ContactData: Object {
    @objc dynamic var phoneNumber = ""
    @objc dynamic var mail = ""
    @objc dynamic var adress = ""
}
