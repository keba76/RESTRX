//
//  PresentTransition.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/5/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//
import Foundation
import UIKit

class PresentTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let detail = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        detail.view.alpha = 0.0
        var frame = containerView.bounds
        frame.origin.y += 20
        frame.size.height -= 20
        detail.view.frame = frame
        
        containerView.addSubview((detail.view))
        
        UIView.animate(withDuration: 0.5, animations: {detail.view.alpha = 1.0}, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
