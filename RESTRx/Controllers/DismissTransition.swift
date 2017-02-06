//
//  DismissTransition.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/5/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit

class DismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let detail = transitionContext.viewController(forKey: .from)
        UIView.animate(withDuration: 0.4, animations: {detail?.view.alpha = 0.0}) { _ in
            detail?.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
}
