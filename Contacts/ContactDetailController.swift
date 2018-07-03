//
//  ContactDetailController.swift
//  Contacts
//
//  Created by Devodriq Roberts on 7/1/18.
//  Copyright © 2018 Devodriq Roberts. All rights reserved.
//

import UIKit

class ContactDetailController: UITableViewController {
    
    var contact: Contact?

    // Outlets
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated..
    }
    
    func configureView() {
        guard let contact = contact else {return}
        profileView.image = contact.image
        nameLabel.text = "\(contact.firstName) \(contact.lastName)"
        phoneNumberLabel.text = contact.phone
        emailLabel.text = contact.email
        streetLabel.text = contact.street
        cityLabel.text = contact.city
        stateLabel.text = contact.state
        zipCodeLabel.text = contact.zip
    }
}














