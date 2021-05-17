//
//  GalleryPresentationTransition.swift
//  clientVK
//
//  Created by Natalia on 14.05.2021.
//

import UIKit

class GalleryPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
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
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        guard let destination = transitionContext.viewController(forKey: .to) as? GalleryViewController else { return }
        
        toView.frame = containerView.bounds
        toView.isHidden = true
        let imageView = UIImageView(frame: fromFrame)
        imageView.image = image
        
        let fade = UIView(frame: toView.frame)
        fade.backgroundColor = .white
        
        containerView.addSubview(toView)
        containerView.addSubview(fade)
        containerView.addSubview(imageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,  animations: {
            imageView.contentMode = .scaleAspectFit
            imageView.frame = destination.photoGalleryView.frame
            
        }, completion: { _ in
            toView.isHidden = false
            imageView.removeFromSuperview()
            fade.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}
    
    

