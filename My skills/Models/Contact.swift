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
    @Persisted var phoneNumber = ""
    @Persisted var mail = ""
    @Persisted var address = ""
    var fullName: String {
        "\(name) \(surname)"
    }
}

class SectionTitleForContact: Object {
    @Persisted var title = ""
    @Persisted var containsContacts = List<Contact>()
}
