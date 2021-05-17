//
//  RotatePushAnimatedTransition.swift
//  clientVK
//
//  Created by Natalia on 12.05.2021.
//

import UIKit
 
class RotatePushAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let w = destination.view.frame.width
        let h = destination.view.frame.height
        let rotate = CGAffineTransform(rotationAngle: .pi / 2)
        let translation = CGAffineTransform(translationX: -(w/2 + h/2), y: -h/2 + w/2)
        destination.view.transform = rotate.concatenating(translation)
        
        UIView.animate(withDuration: 0.6) {
            destination.view.transform = .identity
        } completion: { finished in
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }    

}
