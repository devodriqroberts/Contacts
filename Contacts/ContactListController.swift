//
//  ContactListController.swift
//  Contacts
//
//  Created by Devodriq Roberts on 7/1/18.
//  Copyright © 2018 Devodriq Roberts. All rights reserved.
//

import UIKit


extension Contact {
    var firstLetterForSort: String {
        return String(firstName.prefix(1)).uppercased()
    }
}

extension ContactsSource {
    static var sortUniqueFirstLetters: [String] {
        let firstLetters = contacts.map {$0.firstLetterForSort}
        let uniqueFirstLetter = Set(firstLetters)
        return Array(uniqueFirstLetter).sorted()
    }
    
    static var sectionedContacts: [[Contact]] {
        return sortUniqueFirstLetters.map {firstLetter in
            let filteredContacts = contacts.filter { $0.firstLetterForSort == firstLetter }
            return filteredContacts.sorted(by: { $0.firstName < $1.firstName } )
        }
    }
}

class ContactListController: UITableViewController {
    
   let dataSource = ContactsDataSource(sectionedData: ContactsSource.sectionedContacts, sectionTitles: ContactsSource.sortUniqueFirstLetters)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Mark: - TableV iew Delegate
    
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = dataSource.object(at: indexPath)
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController else {return}
                
                contactDetailController.contact = contact
                contactDetailController.delegate = self
            }
        }
    }
}

extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.street == rhs.street && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.phone == rhs.phone && lhs.email == rhs.email
    }
}

extension ContactListController: ContactDetailControllerDelegate {
   
    
    func didMarkAsFavoriteContact(_ contact: Contact) {
        guard let indexPath = dataSource.indexPath(for: contact) else {
            return
        }
        
        var favoriteContact = dataSource.object(at: indexPath)
        favoriteContact.isFavorite = true
        
        dataSource.updateContact(favoriteContact, at: indexPath)
        tableView.reloadData()
        }
    
    
    func didUnfavoriteContact(_ contact: Contact) {
        guard let indexPath = dataSource.indexPath(for: contact) else {
            return
        }
        
        var favoriteContact = dataSource.object(at: indexPath)
        favoriteContact.isFavorite = false
        
        dataSource.updateContact(favoriteContact, at: indexPath)
        tableView.reloadData()
        }
    
    }





















