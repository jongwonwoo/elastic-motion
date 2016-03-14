//
//  ElasticMotionStateMachine.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import Foundation

enum ElasticMotionState {
    case Closed
    case MayOpen
    case WillOpen
    case Opened
    case MayClose
    case WillClose
}

class ElasticMotionStateMachine {
    var criticalPoint: Float
    var state: ElasticMotionState
    
    init(_ criticalPoint:Float) {
        self.criticalPoint = criticalPoint;
        self.state = .Closed
    }
}