//
//  DataManager.swift
//  My skills
//
//  Created by Artem Pavlov on 14.04.2022.
//

import Foundation

//MARK: - data for PhoneBook project
class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createContactData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            
            let contactOne = Contact()
            contactOne.name = "Jack"
            contactOne.surname = "Riker"
            contactOne.phoneNumber = "3334445555"
            contactOne.mail = "sun@gmail.com"
            
            let sectionTitleContactOne = String(contactOne.surname.prefix(1))
            
            let contactTwo = Contact()
            contactTwo.name = "Sam"
            contactTwo.surname = "Katcher"
            contactTwo.phoneNumber = "2226661111"
            contactTwo.mail = "grow_tt@icloud.com"
            contactTwo.address = "Synny wall"
            
            let sectionTitleContactTwo = String(contactTwo.surname.prefix(1))
            
            let sectionTitleForFirstContact = SectionTitleForContact()
            sectionTitleForFirstContact.title = sectionTitleContactOne
            sectionTitleForFirstContact.containsContacts.append(contactOne)
            
            let sectionTitleForSecondContact = SectionTitleForContact()
            sectionTitleForSecondContact.title = sectionTitleContactTwo
            sectionTitleForSecondContact.containsContacts.append(contactTwo)
            
            DispatchQueue.main.async {
                StorageManagerRealm.shared.save([sectionTitleForFirstContact, sectionTitleForSecondContact])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
}
