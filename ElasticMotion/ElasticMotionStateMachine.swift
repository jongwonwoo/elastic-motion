//
//  ElasticMotionStateMachine.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import Foundation
import CoreGraphics

enum ElasticMotionDirection {
    case Left
    case Right
    case Top
    case Bottom
}

enum ElasticMotionState {
    case Closed
    case MayOpen
    case WillOpen
    case Opened
    case MayClose
    case WillClose
}

class ElasticMotionStateMachine {
    private var direction = ElasticMotionDirection.Right
    private var state = ElasticMotionState.Closed
    private var criticalPoint = Float(0)
    private var beginPoint = CGPointZero
    private var deltaPoint = CGPointZero
    private var vibrationSec = Double(2)
    
    init(_ direction: ElasticMotionDirection, criticalPoint:Float, vibrationSec:Double) {
        self.direction = direction
        self.criticalPoint = criticalPoint
        self.vibrationSec = vibrationSec
    }
    
    func getState() -> ElasticMotionState {
        return self.state
    }
    
    // 어디에서부터든 움직이기 시작하면 may*로 바뀐다.
    // 시작 위치에서 cp 보다 움직이면 will*로 바뀐다.
    // will로 바뀌고 일정시간 후에는 did로 바뀐다.
    func setPoint(point: CGPoint, delta: CGPoint) {
        print("current state:\(self.state)")
        self.sumDeltaPoint(delta)
        
        switch self.state {
        case .Closed, .Opened:
            self.beginPoint = point
            self.moveNextState()
        case .MayOpen, .MayClose:
            if self.isOverCriticalPoint() {
                self.moveNextState()
            }
        default:
            break
        }
    }
    
    func sumDeltaPoint(delta: CGPoint) {
        self.deltaPoint = CGPointMake(self.deltaPoint.x+delta.x, self.deltaPoint.y+delta.y)
    }
    
    func isOverCriticalPoint() -> Bool {
        var result = false
        
        switch self.direction {
        case .Left, .Right:
            result = Float(self.deltaPoint.x) > self.criticalPoint
        case .Top, .Bottom:
            result = Float(self.deltaPoint.y) > self.criticalPoint
        }
        
        return result
    }
    
    func moveNextState() {
        switch self.state {
        case .Closed:
            self.state = .MayOpen
        case .MayOpen:
            self.state = .WillOpen

            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.vibrationSec * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), moveNextState)
        case .WillOpen:
            self.state = .Opened
        case .Opened:
            self.state = .MayClose
        case .MayClose:
            self.state = .WillClose

            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.vibrationSec * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), moveNextState)
        case .WillClose:
            self.state = .Closed
        }
        
        print("current state:\(self.state)")
    }
}