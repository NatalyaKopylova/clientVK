//
//  UserTableViewCell.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    var avatar: UIImageView = {
        let _avatar = UIImageView()
        _avatar.backgroundColor = .red
        _avatar.clipsToBounds = true
        return _avatar
    }()
    
    var nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatar)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let inset: CGFloat = 10.0
   
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarFrame()
        nameFrame()
    }
    
    func avatarFrame() {
        print(contentView.bounds)
        let origin = CGPoint(x: inset, y: inset)
        let height = contentView.bounds.height - inset * 2
        let frame = CGRect(origin: origin, size: CGSize(width: height, height: height))
        avatar.frame = frame
        avatar.layer.cornerRadius = height / 2
    }
    
    func nameFrame() {
        let height: CGFloat = 19
        let origin = CGPoint(x: inset + avatar.bounds.width + inset,
                             y: contentView.bounds.height / 2 - height / 2)
        let width = contentView.bounds.width - inset * 3 - avatar.bounds.width
        let frame = CGRect(origin: origin, size: CGSize(width: width, height: height))
        nameLabel.frame = frame
    }
    
    

}
