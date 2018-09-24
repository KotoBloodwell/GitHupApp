//
//  ScaleTransitionDelegate.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 22/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

protocol Scaling {
    func scalingImageView(transition: ScaleTransitionDelegate) -> UIImageView?
    func scalingUILabel(transition: ScaleTransitionDelegate) -> UILabel?
}

enum TransitionState {
    case begin
    case end
}

class ScaleTransitionDelegate: NSObject {
    let animationDuration = 0.7
    var navigationControllerOperation: UINavigationController.Operation = .none
}

extension ScaleTransitionDelegate: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        var backgroundVC = fromVC
        var foregroundVC = toVC
        
        if navigationControllerOperation == .pop {
            backgroundVC = toVC
            foregroundVC = fromVC
        }
        
        guard let backgroundImageView = (backgroundVC as? Scaling)?.scalingImageView(transition: self) else { return }
        guard let foregroundImageView = (foregroundVC as? Scaling)?.scalingImageView(transition: self) else { return }
        
        guard let backgroundUILabel = (backgroundVC as? Scaling)?.scalingUILabel(transition: self) else { return }
        guard let foregroundUILabel = (foregroundVC as? Scaling)?.scalingUILabel(transition: self) else { return }
        
        let imageViewSnapshot = UIImageView(image: backgroundImageView.image)
        let uiLabelSnapshot =  UILabel(frame: backgroundUILabel.frame)
        
        uiLabelSnapshot.text = backgroundUILabel.text
        uiLabelSnapshot.font = backgroundUILabel.font
        uiLabelSnapshot.textColor = backgroundUILabel.textColor
        
        imageViewSnapshot.contentMode = .scaleAspectFit
        imageViewSnapshot.layer.masksToBounds = true
        
        backgroundImageView.isHidden = true
        foregroundImageView.isHidden = true
        
        backgroundUILabel.isHidden = true
        foregroundUILabel.isHidden = true
        
        if navigationControllerOperation == .pop {
            foregroundUILabel.superview?.isHidden = true
        }
        
        let foregroundBGColor = foregroundVC.view.backgroundColor
        foregroundVC.view.backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.white
        
        containerView.addSubview(backgroundVC.view)
        containerView.addSubview(foregroundVC.view)
        containerView.addSubview(uiLabelSnapshot)
        containerView.addSubview(imageViewSnapshot)
        
        var transitionStateA = TransitionState.begin
        var transitionStateB = TransitionState.end
        
        if navigationControllerOperation == .pop {
            transitionStateA = .end
            transitionStateB = .begin
        }
        
        prepareViews(for: transitionStateA, containerView: containerView, backgroundVC: backgroundVC, backgroundImageView: backgroundImageView, foregroundImageView: foregroundImageView, backgroundUIView: backgroundUILabel, foregroundUIView: foregroundUILabel, snapshotImageView: imageViewSnapshot, snapshotUILabel: uiLabelSnapshot)
        
        foregroundVC.view.layoutIfNeeded()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            self.prepareViews(for: transitionStateB, containerView: containerView, backgroundVC: backgroundVC, backgroundImageView: backgroundImageView, foregroundImageView: foregroundImageView, backgroundUIView: backgroundUILabel, foregroundUIView: foregroundUILabel, snapshotImageView: imageViewSnapshot, snapshotUILabel: uiLabelSnapshot)
        }) { _ in
            backgroundVC.view.transform = .identity
            imageViewSnapshot.removeFromSuperview()
            uiLabelSnapshot.removeFromSuperview()
            
            backgroundImageView.isHidden = false
            foregroundImageView.isHidden = false
            
            backgroundUILabel.isHidden = false
            foregroundUILabel.isHidden = false
            
            foregroundVC.view.backgroundColor = foregroundBGColor
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func prepareViews (for state:TransitionState, containerView: UIView, backgroundVC: UIViewController, backgroundImageView: UIImageView, foregroundImageView: UIImageView, backgroundUIView: UIView, foregroundUIView: UIView, snapshotImageView: UIImageView, snapshotUILabel: UIView){
        switch state {
        case .begin:
            backgroundVC.view.transform = .identity
            backgroundVC.view.alpha = 1
            
            snapshotImageView.frame = containerView.convert(backgroundImageView.frame, from: backgroundImageView.superview)
            snapshotUILabel.frame = containerView.convert(backgroundUIView.frame, from: backgroundUIView.superview)
        case .end:
            backgroundVC.view.alpha = 0
            snapshotImageView.frame = containerView.convert(foregroundImageView.frame, from: foregroundImageView.superview)
            snapshotUILabel.frame = containerView.convert(foregroundUIView.frame, from: foregroundUIView.superview)
        }
    }
}

extension ScaleTransitionDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is Scaling && toVC is Scaling {
            self.navigationControllerOperation = operation
            return self
        } else {
            return nil
        }
    }
}
