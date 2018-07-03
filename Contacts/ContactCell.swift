//
//  ContactCell.swift
//  Contacts
//
//  Created by Devodriq Roberts on 7/2/18.
//  Copyright © 2018 Devodriq Roberts. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
