//
//  IndicatorStackView.swift
//  clientVK
//
//  Created by Natalia on 26.04.2021.
//

import UIKit

class IndicatorView: UIView {
    
    var borderColor = UIColor.systemOrange
    var fillColor = UIColor.white

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setStrokeColor(UIColor.white.cgColor)
    
        guard let cgContext = UIGraphicsGetCurrentContext() else {return}
        cgContext.setStrokeColor(borderColor.cgColor)
        cgContext.setFillColor(fillColor.cgColor)

        let path = UIBezierPath()
        path.lineWidth = 2
        let w = rect.width
        let h = rect.height
        path.move(to: CGPoint(x: w/4, y: 0))
        path.addCurve(to: CGPoint(x: w/8, y: h*5/8), controlPoint1: CGPoint(x: w/8, y: 0), controlPoint2: CGPoint(x: 0, y: h/4))
        path.addCurve(to: CGPoint(x: w/8, y: h), controlPoint1: CGPoint(x: 0, y: h*5/8), controlPoint2: CGPoint(x: 0, y: h))
        path.addCurve(to: CGPoint(x: w*3/4, y: h), controlPoint1: CGPoint(x: w/2, y: h), controlPoint2: CGPoint(x: w/2, y: h))
        path.addCurve(to: CGPoint(x: w*3/4, y: h/2), controlPoint1: CGPoint(x: w, y: h), controlPoint2: CGPoint(x: w, y: h/2))
        path.addCurve(to: CGPoint(x: w/2, y: h*2/5), controlPoint1: CGPoint(x: w*3/4, y: h/8), controlPoint2: CGPoint(x: w/2, y: h/8))
        path.addCurve(to: CGPoint(x: w/4, y: 0), controlPoint1: CGPoint(x: w/2, y: 0), controlPoint2: CGPoint(x: w/4, y: 0))

        path.close()
        path.fill()
        path.stroke()
    
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 0.1424696007, green: 0.1576490746, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = path.cgPath
        shapeLayer.strokeStart = 0.8

        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 0
        startAnimation.toValue = 0.8

        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = 0.2
        endAnimation.toValue = 1.0

        let animation = CAAnimationGroup()
        animation.animations = [startAnimation, endAnimation]
        animation.duration = 2
        animation.repeatCount = Float.infinity
        shapeLayer.add(animation, forKey: "MyAnimation")
        layer.addSublayer(shapeLayer)
    }
}
