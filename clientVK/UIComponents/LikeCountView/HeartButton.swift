//
//  HeartView.swift
//  clientVK
//
//  Created by Natalia on 19.04.2021.
//

import UIKit

class HeartButton: UIButton {
    
    var isLiked = false {
        didSet {
            fillColor = isLiked ? .systemOrange : .clear
            setNeedsDisplay()
        }
    }
    
    var borderColor = UIColor.systemOrange
    var fillColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let cgContext = UIGraphicsGetCurrentContext() else {return}
        cgContext.setStrokeColor(borderColor.cgColor)
        cgContext.setFillColor(fillColor.cgColor)
        
        let path = UIBezierPath()
        path.lineWidth = 2        
        path.move(to: CGPoint(x: 2, y: rect.height / 4))
        path.addCurve(to: CGPoint(x: rect.width / 2, y: rect.height / 4), controlPoint1: CGPoint(x: 2, y: 0), controlPoint2: CGPoint(x: rect.width / 2, y: 0))
        path.addCurve(to: CGPoint(x: rect.width - 2, y: rect.height / 4), controlPoint1: CGPoint(x: rect.width / 2, y: 0), controlPoint2: CGPoint(x: rect.width - 2, y: 0))
        path.addCurve(to: CGPoint(x: rect.width / 2, y: rect.height), controlPoint1: CGPoint(x: rect.width - 2, y: rect.height / 2), controlPoint2: CGPoint(x: rect.width / 2, y: rect.height * 6 / 8))
        path.addCurve(to: CGPoint(x: 2, y: rect.height / 4), controlPoint1: CGPoint(x: rect.width / 2, y: rect.height * 6 / 8), controlPoint2: CGPoint(x: 2, y: rect.height / 2))
        path.close()
        path.fill()
        path.stroke()
    }
}
