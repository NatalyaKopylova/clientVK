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
    
    var didTap: (() -> Void)?
    
    func startAnimation() {
        
        UIView.animate(withDuration: 0.1) {
            self.groupImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    func animateAuthButton() {
        self.groupImageView.transform = .identity
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 100
        animation.mass = 1
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.groupImageView.layer.add(animation, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateAuthButton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.didTap?()
        }
    }
}

