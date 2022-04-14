//
//  DataManager.swift
//  My skills
//
//  Created by Artem Pavlov on 14.04.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createContactData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            
            let contactOne = Contact()
            contactOne.name = "Jack"
            contactOne.surname = "Riker"
            
            let contactTwo = Contact()
            contactTwo.name = "Sam"
            contactTwo.surname = "Katcher"
            
            let firstContactInfo = ContactData(value: ["9-888-777-66-66", "sun@gmail.com", "75'Street"])
            let secondContactInfo = ContactData(value: ["9-888-777-66-66", "sun@gmail.com", "75'Street"])
            
            contactOne.contactsData.append(firstContactInfo)
            contactTwo.contactsData.append(secondContactInfo)
            
            DispatchQueue.main.async {
                StorageManagerRealm.shared.save(contacts: [contactOne, contactTwo])
            }
        }
    }
}
