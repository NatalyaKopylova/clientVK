//
//  FirstLetterSectionHeaderView.swift
//  clientVK
//
//  Created by Natalia on 21.04.2021.
//

import UIKit

class FirstLetterSectionHeaderView: UIView {
    
    let letter = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configSubviews()
    }
    
    private func configSubviews() {
        addSubview(letter)
        
        letter.translatesAutoresizingMaskIntoConstraints = false
        letter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        letter.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        backgroundColor = UIColor.init(white: 1, alpha: 0.7)
    }
}
