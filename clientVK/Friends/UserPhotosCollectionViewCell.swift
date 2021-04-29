//
//  UserPhotosCollectionViewCell.swift
//  clientVK
//
//  Created by Natalia on 13.04.2021.
//

import UIKit

class UserPhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func startAnimate() {
        self.imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        self.imageView.alpha = 0
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: [.autoreverse],
                       animations: {
            self.imageView.transform = .identity
            self.imageView.alpha = 1
        })
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startAnimate()
    }  
}
