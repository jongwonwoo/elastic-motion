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

protocol ElasticMotionStateMachineDelegate {
    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState state:ElasticMotionState, deltaPoint:CGPoint)
}

class ElasticMotionStateMachine {
    internal private(set) var direction = ElasticMotionDirection.Right
    internal private(set) var state: ElasticMotionState = .Closed {
        didSet {
            self.delegate?.elasticMotionStateMachine(self, didChangeState: self.state, deltaPoint: self.deltaPoint)
//            print("setState:\(self.state), total:\(self.totalMovingPoint), delta:\(self.deltaPoint)")
            
            if self.state == .Closed || self.state == .Opened {
                self.deltaPoint = CGPointZero
                self.totalMovingPoint = CGPointZero
            }
        }
    }
    private var criticalPoint = Float(0)
    private var beginPoint = CGPointZero
    private var deltaPoint = CGPointZero
    private var totalMovingPoint = CGPointZero
    private var vibrationSec = Double(2)
    
    var delegate: ElasticMotionStateMachineDelegate?
    
    // MARK: - public functions
    init(_ direction: ElasticMotionDirection, criticalPoint:Float, vibrationSec:Double) {
        self.direction = direction
        self.criticalPoint = criticalPoint
        self.vibrationSec = vibrationSec
    }
    
    func keepMoving(currentPoint: CGPoint) {
        if self.state == .Closed || self.state == .WillClose || self.state == .Opened || self.state == .WillOpen {
            self.beginPoint = currentPoint
            self.totalMovingPoint = CGPointZero
        }
        
        let delta = self.deltaPointFromCurrentPoint(currentPoint)
        self.addMovingPoint(delta)
        
        print("setPoint:\(self.state), current:\(currentPoint), begin:\(self.beginPoint), total:\(self.totalMovingPoint), delta:\(self.deltaPoint)")
        
        self.changeState()

    }
    
    func stopMoving() {
        switch self.state {
        case .MayOpen, .MayClose:
            self.movePreviousState()
        default:
            break
        }
    }

    //MARK: - about point
    private func deltaPointFromCurrentPoint(currentPoint: CGPoint) -> CGPoint {
        self.deltaPoint = CGPointMake(currentPoint.x - self.beginPoint.x - self.totalMovingPoint.x, currentPoint.y - self.beginPoint.y - self.totalMovingPoint.y)
        
        return self.deltaPoint
    }
    
    private func addMovingPoint(delta: CGPoint) {
        self.totalMovingPoint = CGPointMake(self.totalMovingPoint.x + delta.x, self.totalMovingPoint.y + delta.y)
    }
    
    private func isOverCriticalPoint() -> Bool {
        var result = false
        
        switch self.direction {
        case .Left:
            //TODO
            result = Float(self.totalMovingPoint.x) > self.criticalPoint
        case .Right:
            if self.state == .MayOpen {
                result = Float(self.totalMovingPoint.x) > self.criticalPoint
            } else if self.state == .MayClose {
                result = -(Float(self.totalMovingPoint.x)) > self.criticalPoint
            }
        case .Top:
            //TODO
            result = Float(self.totalMovingPoint.y) > self.criticalPoint
        case .Bottom:
            //TODO
            result = Float(self.totalMovingPoint.y) > self.criticalPoint
        }
        
        return result
    }
    
    // MARK: - state
    
    // 어디에서부터든 움직이기 시작하면 may*로 바뀐다.
    // 시작 위치에서 cp 보다 움직이면 will*로 바뀐다.
    // will로 바뀌고 일정시간 후에는 did로 바뀐다.
    private func changeState() {
        switch self.state {
        case .Closed, .Opened:
            self.moveNextState()
        case .MayOpen, .MayClose:
            if self.isOverCriticalPoint() {
                self.moveNextState()
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.vibrationSec * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), moveNextState)
            } else {
                self.stayCurrentState()
            }
        default:
            break
        }
    }
    
    private func stayCurrentState() {
        let currentState = self.state
        self.state = currentState
    }
    
    private func moveNextState() {
        switch self.state {
        case .Closed:
            self.state = .MayOpen
        case .MayOpen:
            self.state = .WillOpen
        case .WillOpen:
            self.state = .Opened
        case .Opened:
            self.state = .MayClose
        case .MayClose:
            self.state = .WillClose
        case .WillClose:
            self.state = .Closed
        }
    }
    
    private func movePreviousState() {
        switch self.state {
        case .MayOpen:
            self.state = .Closed
        case .MayClose:
            self.state = .Opened
        default:
            break
        }
    }
}