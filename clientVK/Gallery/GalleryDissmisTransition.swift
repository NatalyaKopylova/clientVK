//
//  GalleryDissmisTransition.swift
//  clientVK
//
//  Created by Natalia on 14.05.2021.
//

import UIKit

class GalleryDissmisTransition: NSObject, UIViewControllerAnimatedTransitioning  {
   
    let fromFrame: CGRect
    let toFrame: CGRect
    let image: UIImage
    
    init(fromFrame: CGRect, toFrame: CGRect, image: UIImage) {
        self.fromFrame = fromFrame
        self.toFrame = toFrame
        self.image = image
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
//        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
//        guard let destination = transitionContext.viewController(forKey: .to) as? GalleryViewController else { return }

        let imageView = UIImageView(frame: fromFrame)
        imageView.image = image
        
        containerView.addSubview(imageView)
        fromView.removeFromSuperview()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,  animations: {
                        imageView.frame = self.toFrame
            
        }, completion: { _ in
            imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
