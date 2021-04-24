//
//  MyButtonNewsScreen.swift
//  clientVK
//
//  Created by Natalia on 22.04.2021.
//

import UIKit

@IBDesignable
class MyButtonNewsScreen: UIButton {
    
    @IBInspectable var text:String? {
        get { label.text }
        set { label.text = newValue }
    }
    @IBInspectable var icon: UIImage? {
        get { image.image }
        set { image.image = newValue }
    }
    
    let stack = UIStackView()
    
    let image = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configSubviews()
    }
    
    private func configSubviews() {
        setTitle(nil, for: .normal)
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stack.axis = .horizontal
        
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(label)
    }
    
    override func prepareForInterfaceBuilder() {
        configSubviews()
    }
}
