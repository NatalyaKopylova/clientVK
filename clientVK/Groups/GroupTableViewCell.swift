//
//  GroupTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 14.04.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDescriptionLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    var group: Group?
}
