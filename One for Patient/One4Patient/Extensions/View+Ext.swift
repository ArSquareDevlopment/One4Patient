//
//  View+Ext.swift
//  One for Patient
//
//  Created by Idontknow on 21/11/19.
//  Copyright © 2019 AnnantaSourceLLc. All rights reserved.
//

import Foundation
import UIKit
import Lottie



//CompletionBlock
typealias CompletionBlock = (() -> ())

//MARK:- Animation Related
extension UIView {
    
    func animate(withType: [AnimationType], reversed: Bool = false, initialAlpha: CGFloat = 0.0, finalAlpha: CGFloat = 1.0, delay: Double = 0.0, duration: TimeInterval = AnimationConfiguration.duration, backToOriginalForm: Bool = false, completion: CompletionBlock? = nil) {
        
        let transformFrom = transform
        var transformTo = transform
        
        withType.forEach { (viewTransform) in
            transformTo = transformTo.concatenating(viewTransform.initialTransform)
        }
        
        if reversed == false {
            transform = transformTo
        }
        
        alpha = initialAlpha
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: duration, delay: delay, options: [.curveLinear, .curveEaseInOut], animations: { [weak self] in
                self?.transform = reversed == true ? transformTo : transformFrom
                self?.alpha = finalAlpha
            }, completion: { (_) in
                completion?()
                if backToOriginalForm == true {
                    UIView.animate(withDuration: 0.35, delay: 0.0, options: [.curveLinear, .curveEaseInOut], animations: { [weak self] in
                        self?.transform = .identity
                    }, completion: nil)
                }
            })
        }
    }
    
    /*
     Parameters:
        - withType: Animations to perform.
        - interval: Interval of the animations between subviews.
    */
    func animateAll(withType: [AnimationType], interval: Double = AnimationConfiguration.interval) {
        for(index, value) in subviews.enumerated() {
            let delay = Double(index) * interval
            value.animate(withType: withType, delay: delay)
        }
    }
    
    /*
     Parameter
        - interval: Interval of the animations between subviews.
    */
    func animationRandom(interval: Double = AnimationConfiguration.interval) {
        for(index, value) in subviews.enumerated() {
            let delay = Double(index) * interval
            let animationRandom = AnimationType.random()
            value.animate(withType: [animationRandom], delay: delay)
        }
    }
    
    //It will restore all subview to it's identity
    func restoreAllViewToIdentity() {
        for(_, value) in subviews.enumerated() {
            value.transform = CGAffineTransform.identity
        }
    }

   
    
//    MARK: LOttie Animation
     func playAnimation(fileName:String) {

    let animView = AnimationView(name: fileName)
    animView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    animView.center  = self.center
    self.addSubview(animView)
    animView.loopMode = .loop
    animView.sizeToFit()
    animView.animationSpeed = 1.0
    animView.play()
    //        animView.stop()
        }
    
//  MARK: Activity Indicatior
    
   func showActivityIndicator() {
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.backgroundColor = .clear
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .black
        activityIndicator.color = UIColor.baseColor
        activityIndicator.tag = 1
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    func hideActivityIndicator() {
        let activityIndicator = self.viewWithTag(1) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
    // Add BlurEffect to view
    func addBlurEffect()  {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
    self.addSubview(blurEffectView)
    }
        
        /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
    let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
    blurredEffectViews.forEach{ blurView in
    blurView.removeFromSuperview()
    }
    }
        
    func makeRounded() {
    self.layer.borderWidth = 0.5
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.cornerRadius = self.frame.height/2
    }
    
    func showBorder() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 5.0
    }
   
   
//  Mark: View Popup animation
    func showPopupAnimation() {
        self.isHidden = false
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
        //use if you want to darken the background
          //self.viewDim.alpha = 0.8
          //go back to original form
          self.transform = .identity
        })
    }
    func hidePopupAnimiation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
        //use if you wish to darken the background
          //self.viewDim.alpha = 0
          self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        }) { (success) in
          self.removeFromSuperview()

        }
    }
    
// Animation From Bottom
    func showBottomAnimation() {
        
    self.isHidden = false
    UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn], animations: {
    self.center.y -= self.bounds.height
    self.layoutIfNeeded()  }, completion: nil)
    }
    
//    View Hide to bottom
    func hideBottomAnimation() {
        
    UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],animations: {
    self.center.y += self.bounds.height
    self.layoutIfNeeded() },  completion: {(_ completed: Bool) -> Void in
    self.isHidden = true
    })
    }
    
    
//    MARK: Stack View Anaimtion
    func hideAnimated(in stackView: UIStackView) {
        if !self.isHidden {
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.isHidden = true
                    stackView.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }

    func showAnimated(in stackView: UIStackView) {
        
        
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    stackView.isHidden = false
                    stackView.layoutIfNeeded()
                },
                completion: nil
            )
        
    }
    
    
}

   
    
    
extension UITableView {
    // Mark:  TableView reloading with animation
    func reloadWithAnimation() {
    self.reloadData()
    let tableViewHeight = self.bounds.size.height
    let cells = self.visibleCells
    var delayCounter = 0
    for cell in cells {
    cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
    }
   for cell in cells {
    UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
    cell.transform = CGAffineTransform.identity
    }, completion: nil)
    delayCounter += 1
        }
    }
    
    func fadeVisibleCells() {
    var delayCounter = 0.0
    for cell in self.visibleCells {
    cell.alpha = 0.0
    UIView.animate(withDuration: TimeInterval(delayCounter)) {
    cell.alpha = 1.0
    }
     delayCounter += 0.30
        }
    }
    
    
    func reloadWithType(type:AnimationDirectionType) {
        for subViews in self.visibleCells {
            let leftAnimation = AnimationType.from(direction: type, offSet: 30.0)
            subViews.contentView.animateAll(withType: [leftAnimation])
        }
        self.reloadData()

    }
    
    func reloadByZoom() {
        for subViews in self.visibleCells {
            let zoomInAnimation = AnimationType.zoom(scale: 0.8)
            subViews.contentView.animateAll(withType: [zoomInAnimation])
        }
        self.reloadData()
    }
    
    

    
}
  
 

