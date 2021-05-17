//
//  RotatePopAnimation.swift
//  clientVK
//
//  Created by Natalia on 12.05.2021.
//

import UIKit

class RotatePopAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.frame = source.view.frame
        let w = destination.view.frame.width
        let h = destination.view.frame.height
        let rotate = CGAffineTransform(rotationAngle: .pi / 2)
        let translation = CGAffineTransform(translationX: -(w/2 + h/2), y: -h/2 + w/2)

        UIView.animate(withDuration: 0.6) {
            source.view.transform = rotate.concatenating(translation)
        } completion: { finished in
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}
 
