//
//  IndicatorStackView.swift
//  clientVK
//
//  Created by Natalia on 26.04.2021.
//

import UIKit

class IndicatorStackView: UIStackView {
    
    let point1 = UIView()
    let point2 = UIView()
    let point3 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configSubviews()
    }
    
    func configSubviews() {
        addArrangedSubview(point1)
        addArrangedSubview(point2)
        addArrangedSubview(point3)
        spacing = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        point1.layer.cornerRadius = point1.bounds.width / 2
        point1.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        point2.layer.cornerRadius = point2.bounds.width / 2
        point2.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        point3.layer.cornerRadius = point3.bounds.width / 2
        point3.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        point1.clipsToBounds = true
        point2.clipsToBounds = true
        point3.clipsToBounds = true
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 3,
                       delay: 0,
                       options: [.autoreverse, .repeat],
                       animations: {
                        self.point1.backgroundColor = .white
                        self.point1.alpha = 1
                       })
        UIView.animate(withDuration: 3,
                       delay: 2, options: [.autoreverse, .repeat],
                       animations: {
                        self.point2.backgroundColor = .white
                        self.point2.alpha = 1
                       })
        UIView.animate(withDuration: 3,
                       delay: 4, options: [.autoreverse, .repeat],
                       animations: {
                        self.point3.backgroundColor = .white
                        self.point3.alpha = 1
                       })
    }
}
