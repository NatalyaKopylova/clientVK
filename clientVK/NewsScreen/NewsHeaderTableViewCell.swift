//
//  NewsHeaderTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 07.07.2021.
//

import UIKit

class NewsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var headerNewsLabel: UILabel!
    
    @IBOutlet weak var timeOfNewsCreationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
