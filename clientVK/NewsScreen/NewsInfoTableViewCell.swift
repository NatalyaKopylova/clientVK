//
//  NewsInfoTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 07.07.2021.
//

import UIKit

class NewsInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: MyButtonNewsScreen!
    
    @IBOutlet weak var commentsButton: MyButtonNewsScreen!
    
    @IBOutlet weak var repostButton: MyButtonNewsScreen!
    
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
