//
//  GalleryTransitionDelegate.swift
//  clientVK
//
//  Created by Natalia on 14.05.2021.
//

import UIKit

class GalleryTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let presentationTransition: GalleryPresentationTransition
    var dismissedTransition: GalleryDissmisTransition?
    
    
    init(fromFrame: CGRect, toFrame: CGRect, image: UIImage) {
        self.presentationTransition = GalleryPresentationTransition(fromFrame: fromFrame, toFrame: toFrame, image: image)
//        self.dismissedTransition = GalleryDissmisTransition(fromFrame: fromFrame, toFrame: toFrame, image: image)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentationTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissedTransition 
    }
//
    deinit {
        print("egc")
    }
    
}
