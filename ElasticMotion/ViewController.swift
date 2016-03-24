//
//  ViewController.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ElasticMotionStateMachineDelegate {

    var stateMachine:ElasticMotionStateMachine?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, criticalPoint: 50.0, vibrationSec: 2.0)
        self.stateMachine?.delegate = self
        
//        //TODO: add elasticmotionstatemachine test
//        if let stateMachine = self.stateMachine {
//            stateMachine.setPoint(CGPointMake(0, 0), delta:CGPointMake(1, 0))
//            stateMachine.setPoint(CGPointMake(1, 0), delta:CGPointMake(1, 1))
//            stateMachine.setPoint(CGPointMake(2, 1), delta:CGPointMake(3, 1))
//            stateMachine.setPoint(CGPointMake(5, 0), delta:CGPointMake(1, 1))
//            stateMachine.setPoint(CGPointMake(6, 0), delta:CGPointMake(3, 1))
//            stateMachine.setPoint(CGPointMake(9, 0), delta:CGPointMake(1, 1))
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState state: ElasticMotionState, deltaPoint: CGPoint) {
        if stateMachine.direction == ElasticMotionDirection.Right {
            let fullOpenedWidth = CGFloat(stateMachine.criticalPoint) * 2
            switch state {
            case .MayOpen:
                let newOriginX = self.view.frame.origin.x + deltaPoint.x
                if newOriginX >= 0 && newOriginX < CGFloat(stateMachine.criticalPoint) {
                    self.view.center = CGPointMake(self.view.center.x + deltaPoint.x, self.view.center.y)
                }
            case .MayClose:
                let newOriginX = self.view.frame.origin.x + deltaPoint.x
                if newOriginX >= 0 && newOriginX < fullOpenedWidth {
                    self.view.center = CGPointMake(self.view.center.x + deltaPoint.x, self.view.center.y)
                }
            case .WillClose:
                self.view.center = CGPointMake(self.view.frame.width / 2 + CGFloat(stateMachine.criticalPoint), self.view.center.y)
            case .Closed:
                self.view.center = CGPointMake(self.view.frame.width / 2, self.view.center.y)
            case .WillOpen:
                self.view.center = CGPointMake(self.view.frame.width / 2 + CGFloat(stateMachine.criticalPoint), self.view.center.y)
            case .Opened:
                self.view.center = CGPointMake(self.view.frame.width / 2 + fullOpenedWidth, self.view.center.y)
            }
        }
        // TODO other directions
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let currentPoint = recognizer.translationInView(self.view)

        if let stateMachine = self.stateMachine {
            switch recognizer.state {
            case .Cancelled:
                stateMachine.stopMoving()
            case .Ended:
                stateMachine.stopMoving()
            default:
                stateMachine.keepMoving(currentPoint)
            }
        }
    }
}

