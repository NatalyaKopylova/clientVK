//
//  NewsTextTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 07.07.2021.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {

    @IBOutlet weak var textNewsLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var isExpanded: Bool { textNewsLabel.numberOfLines == 0 }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func changeHeight() {
        guard let tableView = superview as? UITableView else {
            return
        }
        tableView.beginUpdates()
        expandButton.setTitle(isExpanded ? "больше" : "меньше" , for: .normal)
        textNewsLabel.numberOfLines = isExpanded ? 1 : 0
        tableView.endUpdates()
    }
}
