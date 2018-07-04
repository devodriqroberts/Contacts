//
//  ContactsDataSource.swift
//  Contacts
//
//  Created by Devodriq Roberts on 7/3/18.
//  Copyright © 2018 Devodriq Roberts. All rights reserved.
//

import Foundation
import UIKit

class ContactsDataSource: NSObject, UITableViewDataSource {
    private var sectionedData: [[Contact]]
    var sectionTitles: [String]
    
    init(sectionedData: [[Contact]], sectionTitles: [String]) {
        self.sectionedData = sectionedData
        self.sectionTitles = sectionTitles
        
        super.init()
    }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTitles[section]
        }
        
        func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            return sectionTitles
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return sectionedData.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sectionedData[section].count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {fatalError()}
            
            let contact = sectionedData[indexPath.section][indexPath.row]
            contactCell.profileImageView.image = contact.image
            contactCell.nameLable.text = "\(contact.firstName) \(contact.lastName)"
            contactCell.cityLabel.text = contact.city
            
            if contact.isFavorite {
                contactCell.favoriteIcon.image = #imageLiteral(resourceName: "Star")
            } else {
                contactCell.favoriteIcon.image = nil 
            }
            
            
            
            return contactCell
        }
        
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
    
    //MArk:- Helper Methods
    
    func object( at indexPath: IndexPath) -> Contact {
        return sectionedData[indexPath.section][indexPath.row]
    }
    
    func indexPath(for contact: Contact) -> IndexPath? {
        for (index, contacts) in sectionedData.enumerated() {
            if let indexOfContact = contacts.index(of: contact) {
                return IndexPath(row: indexOfContact, section: index)
            }
        }
        
        return nil 
    }
    
    func updateContact(_ contact: Contact, at indexPath: IndexPath) {
        sectionedData[indexPath.section][indexPath.row] = contact
    }
}

















