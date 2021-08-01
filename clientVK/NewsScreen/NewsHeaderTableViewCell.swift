//
//  NewsHeaderTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 07.07.2021.
//

import UIKit
import RealmSwift
import AlamofireImage

class NewsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var headerNewsLabel: UILabel!
    @IBOutlet weak var timeOfNewsCreationLabel: UILabel!
    
    var sourceId = 0 {
        didSet {
            sourceId > 0 ? updateWithUser() : updateWithGroup()
        }
    }
    
    func updateWithUser() {
        let realm = try! Realm()
        if let user = realm.objects(User.self).filter("id == \(sourceId)").first {
            headerNewsLabel.text = user.name
            if let avatarUrl = user.avatar, let url = URL(string: avatarUrl) {
                avatarImageView.af.setImage(withURL: url)
            }
        } else {
            VKService().getUser(id: sourceId) { [weak self] in
                guard let self = self else { return }
                let user = realm.objects(User.self).filter("id == \(self.sourceId)").first!
                self.headerNewsLabel.text = user.name
                if let avatarUrl = user.avatar, let url = URL(string: avatarUrl) {
                    self.avatarImageView.af.setImage(withURL: url)
                }
            }
        }
    }
    
    func updateWithGroup() {
        let realm = try! Realm()
        if let group = realm.objects(Group.self).filter("id == \(-sourceId)").first {
            headerNewsLabel.text = group.name
            if let avatarUrl = group.groupImage, let url = URL(string: avatarUrl) {
                avatarImageView.af.setImage(withURL: url)
            }
        } else {
            VKService().getGroup(id: sourceId) { [weak self] in
                guard let self = self else { return }
                let group = realm.objects(Group.self).filter("id == \(-self.sourceId)").first!
                self.headerNewsLabel.text = group.name
                if let avatarUrl = group.groupImage, let url = URL(string: avatarUrl) {
                    self.avatarImageView.af.setImage(withURL: url)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
