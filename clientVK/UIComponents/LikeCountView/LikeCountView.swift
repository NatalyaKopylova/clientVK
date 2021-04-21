//
//  LikeCountView.swift
//  clientVK
//
//  Created by Natalia on 19.04.2021.
//

import UIKit

@IBDesignable
class LikeCountView: UIStackView {
    
    let heartButton = HeartButton()
    let countLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configSubviews()
    }
    
    private func configSubviews() {
        backgroundColor = .clear
        axis = .horizontal
        spacing = 3

        heartButton.backgroundColor = .clear
        heartButton.addTarget(self, action: #selector(didTap), for: .touchDown)
        heartButton.widthAnchor.constraint(equalTo: heartButton.heightAnchor).isActive = true
        heartButton.backgroundColor = .clear
        addArrangedSubview(heartButton)
        addArrangedSubview(countLabel)
        countLabel.text = "0"
        countLabel.textColor = .systemOrange
        countLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    override func prepareForInterfaceBuilder() {
        configSubviews()
    }
    
    @objc private func didTap() {
        heartButton.isLiked.toggle()
        countLabel.text = heartButton.isLiked ? "1" : "0"
    }

}
