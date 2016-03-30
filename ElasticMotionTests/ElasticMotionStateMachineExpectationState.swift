//
//  ElasticMotionStateMachineExpectationState.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 30..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import Foundation

enum ElasticMotionStateMachineExpectationState: String {
    case MayOpen
    case WillOpen
    case Opened
    case MayOpenThenClosed
    case MayClose
    case MayCloseThenOpened
    case WillClose
    case Closed
}