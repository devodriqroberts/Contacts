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
    
    var sections = ContactsSource.sectionedContacts
    let sectionTitles = ContactsSource.sortUniqueFirstLetters

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Data Source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {fatalError()}
        
        let contact = sections[indexPath.section][indexPath.row]
        contactCell.profileImageView.image = contact.image
        contactCell.nameLable.text = "\(contact.firstName) \(contact.lastName)"
        contactCell.cityLabel.text = contact.city
        
        if contact.isFavorite {
            contactCell.favoriteIcon.image = #imageLiteral(resourceName: "Star")
        }
        
        
        return contactCell
    }
    
    //Mark: - TableV iew Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContact" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let contact = sections[indexPath.section][indexPath.row]
                
                guard let navigationController = segue.destination as? UINavigationController, let contactDetailController = navigationController.topViewController as? ContactDetailController else {return}
                
                contactDetailController.contact = contact
            }
        }
    }
}




















