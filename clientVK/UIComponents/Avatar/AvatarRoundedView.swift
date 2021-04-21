//
//  AvatarRoundedView.swift
//  clientVK
//
//  Created by Natalia on 19.04.2021.
//

import UIKit

@IBDesignable
class AvatarRoundedView: UIView {
    
    let avatar = UIImageView()
    let shadow = UIView()
    
    @IBInspectable var shadowOpacity: Float {
        set { shadow.layer.shadowOpacity = newValue }
        get { return shadow.layer.shadowOpacity }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set { shadow.layer.shadowRadius = newValue }
        get { return shadow.layer.shadowRadius }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get { guard let shadowColor = shadow.layer.shadowColor
            else {return nil}
        return UIColor(cgColor: shadowColor)
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            super.backgroundColor = backgroundColor
            shadow.isHidden = backgroundColor == .clear
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configSubviews()
    }
    
    private func configSubviews() {
        addSubview(shadow)
        addSubview(avatar)

        shadow.backgroundColor = .white
//первые три строки настраиваются в сториборде, как сделать по умолчанию их - не разобрала
        shadow.layer.shadowColor = UIColor.systemOrange.cgColor
        shadow.layer.shadowOpacity = 0.9
        shadow.layer.shadowRadius = 10
        shadow.layer.shadowOffset = CGSize.zero
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        shadow.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        avatar.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.layer.cornerRadius = avatar.bounds.width / 2
        shadow.layer.cornerRadius = shadow.bounds.width / 2
        avatar.clipsToBounds = true
    }
}
