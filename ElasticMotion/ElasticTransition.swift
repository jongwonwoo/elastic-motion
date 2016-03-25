//
//  ElasticTransition.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 25..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import Foundation
import UIKit

public class ElasticTransition : NSObject, UIViewControllerAnimatedTransitioning {
    var transitionDuration: NSTimeInterval
    var presentingViewWidth: Float
    
    init(transitionDuration: NSTimeInterval, presentingViewWidth: Float) {
        self.transitionDuration = transitionDuration
        self.presentingViewWidth = presentingViewWidth
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.transitionDuration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    // This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
    public func animationEnded(transitionCompleted: Bool) {
        
    }
}