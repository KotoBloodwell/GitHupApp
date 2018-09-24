//
//  UIViewAnimations.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 22/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

class UIViewAnimations: NSObject {
    
    static let basicAnimationDuration: TimeInterval = 0.5
    
    class func replaceContentFromAbove(currentView: UIView, initialContent: UIView, newContent: UIView, reverse: Bool = false, complete: @escaping () -> Void) {
        let midCoordinatesNewContent = currentView.frame.midY + newContent.frame.height / 2
        
        // Transformation type
        let transformationOldContent: CGAffineTransform = reverse ? CGAffineTransform(translationX: 0, y: currentView.frame.height) : .identity
        let transformationNewContent: CGAffineTransform = reverse ? CGAffineTransform(translationX: 0, y: midCoordinatesNewContent) : .identity
        
        // Apply Animation
        UIView.animate(withDuration: basicAnimationDuration, animations:{
            initialContent.transform = transformationOldContent
            newContent.transform = transformationNewContent
        }, completion: { (finished: Bool) in
            complete()
        })
    }
    
    class func shake(viewLayer: CALayer){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        viewLayer.add(animation, forKey: "shake")
    }
    
}
