//
//  Contact.swift
//  My skills
//
//  Created by Artem Pavlov on 13.04.2022.
//

import RealmSwift

class Contact: Object {
    @Persisted var name = ""
    @Persisted var surname = ""
    var fullName: String {
        "\(name) \(surname)"
    }
    @Persisted var contactsData = List<ContactData>()
}

class ContactData: Object {
    @Persisted var phoneNumber = ""
    @Persisted var mail = ""
    @Persisted var adress = ""
}
