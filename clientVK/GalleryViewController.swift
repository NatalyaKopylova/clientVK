//
//  GalleryViewController.swift
//  clientVK
//
//  Created by Natalia on 30.04.2021.
//

import UIKit

class GalleryViewController: UIViewController {

  
    @IBOutlet weak var photoGalleryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBInspectable var inactiveIndicatorColor: UIColor = UIColor.lightGray
    @IBInspectable var activeIndicatorColor: UIColor = UIColor.black
    private var images = [UIImage]()
    private var currentIndex = 0
    private var interactiveAnimator: UIViewPropertyAnimator!
    private var mainImageView = UIImageView() //UIView()
    private var secondaryImageView = UIImageView() //UIView()
    private var isLeftSwipe = false
    private var isRightSwipe = false
    private var chooseFlag = false
   
    private var customPageView = UIPageControl()
    
    func setup() {
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        photoGalleryView.addGestureRecognizer(recognizer)
        
        mainImageView.backgroundColor = UIColor.clear
        mainImageView.frame = photoGalleryView.bounds
        mainImageView.contentMode = .scaleAspectFit
        photoGalleryView.addSubview(mainImageView)
        
        secondaryImageView.backgroundColor = UIColor.clear
        secondaryImageView.frame = photoGalleryView.bounds
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        secondaryImageView.contentMode = .scaleAspectFit
        photoGalleryView.addSubview(secondaryImageView)
        
        customPageView.backgroundColor = UIColor.clear
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = self.images.count
        customPageView.currentPage = currentIndex
        customPageView.pageIndicatorTintColor = self.inactiveIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        photoGalleryView.addSubview(customPageView)
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: photoGalleryView.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(equalTo: photoGalleryView.bottomAnchor, constant: -photoGalleryView.bounds.height / 15).isActive = true
    }
    
    
    private func onChange(isLeft: Bool) {
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        self.mainImageView.image = images[currentIndex]
        
        if isLeft {
            self.secondaryImageView.image = images[self.currentIndex + 1]
            self.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }
        else {
            self.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
            self.secondaryImageView.image = images[currentIndex - 1]
        }
    }
    
    
    private func onChangeCompletion(isLeft: Bool) {
        self.mainImageView.transform = .identity
        self.secondaryImageView.transform = .identity
        if isLeft {
            self.currentIndex += 1
        }
        else {
            self.currentIndex -= 1
        }
        self.mainImageView.image = self.images[self.currentIndex]
        photoGalleryView.bringSubviewToFront(self.mainImageView)
        self.customPageView.currentPage = self.currentIndex
    }
    
    
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        if let animator = interactiveAnimator,
           animator.isRunning {
            return
        }
        
        switch recognizer.state {
        case .began:
            self.mainImageView.transform = .identity
            self.mainImageView.image = images[currentIndex]
            self.secondaryImageView.transform = .identity
            photoGalleryView.bringSubviewToFront(self.mainImageView)
            
            interactiveAnimator?.startAnimation()
            interactiveAnimator = UIViewPropertyAnimator(duration: 2,
                                                         curve: .easeInOut,
                                                         animations: { [weak self] in
                                                            self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                                                         })
            interactiveAnimator.pauseAnimation()
            isLeftSwipe = false
            isRightSwipe = false
            chooseFlag = false
        case .changed:
            var translation = recognizer.translation(in: photoGalleryView)
            
            print(translation)
            
            
            if translation.x < 0 && (!isLeftSwipe) && (!chooseFlag) {
                if self.currentIndex == (images.count - 1) {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                chooseFlag = true
                onChange(isLeft: true)
                
                
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0).scaledBy(x: 0.5, y: 0.5)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: true)
                })
                
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isLeftSwipe = true
            }
            
            if translation.x > 0 && (!isRightSwipe) && (!chooseFlag) {
                if self.currentIndex == 0 {
                    interactiveAnimator.stopAnimation(true)
                    return
                }
                chooseFlag = true
                onChange(isLeft: false)
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0).scaledBy(x: 0.5, y: 0.5)
                    self?.secondaryImageView.transform = .identity
                }
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.onChangeCompletion(isLeft: false)
                })
                interactiveAnimator.startAnimation()
                interactiveAnimator.pauseAnimation()
                isRightSwipe = true
            }
            
            if isRightSwipe && (translation.x < 0) {return}
            if isLeftSwipe && (translation.x > 0) {return}
            
            if translation.x < 0 {
                translation.x = -translation.x
            }
            interactiveAnimator.fractionComplete = translation.x / (UIScreen.main.bounds.width)
            
        case .ended:
            if let animator = interactiveAnimator,
               animator.isRunning {
                return
            }
            var translation = recognizer.translation(in: photoGalleryView)
            
            if translation.x < 0 {translation.x = -translation.x}
            
            if (translation.x / (UIScreen.main.bounds.width)) > 0.5  {
                interactiveAnimator.startAnimation()
            }
            else {
                interactiveAnimator.stopAnimation(true)
                interactiveAnimator.finishAnimation(at: .start)
                interactiveAnimator.addAnimations { [weak self] in
                    self?.mainImageView.transform = .identity
                    guard let weakSelf = self else {return}
                    if weakSelf.isLeftSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
                    }
                    if weakSelf.isRightSwipe {
                        self?.secondaryImageView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                    }
                }
                
                interactiveAnimator.addCompletion({ [weak self] _ in
                    self?.mainImageView.transform = .identity
                    self?.secondaryImageView.transform = .identity
                })
                
                interactiveAnimator.startAnimation()
            }
        default:
            return
        }
    }
    
    
    func setImages(images: [UIImage], currentIndex: Int) {
        self.images = images
        self.mainImageView.image = self.images[currentIndex]
        self.currentIndex = currentIndex
        customPageView.numberOfPages = self.images.count
        
    }
   
    
}



