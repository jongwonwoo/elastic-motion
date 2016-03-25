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
    let threshold = Float(50.0)
    let menuViewWidth = Float(100.0)
    
    var transition = ElasticTransition(transitionDuration: 1.0, presentingViewWidth: Float(100.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, threshold: threshold, vibrationSec: 2.0)
        self.stateMachine?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState state: ElasticMotionState, deltaPoint: CGPoint) {
        if stateMachine.direction == ElasticMotionDirection.Right {
            let fullOpenedWidth = CGFloat(menuViewWidth)
            switch state {
            case .MayOpen:
                let newOriginX = self.view.frame.origin.x + deltaPoint.x
                if newOriginX >= 0 && newOriginX < CGFloat(threshold) {
                    self.view.center = CGPointMake(self.view.center.x + deltaPoint.x, self.view.center.y)
                }
            case .MayClose:
                let newOriginX = self.view.frame.origin.x + deltaPoint.x
                if newOriginX >= 0 && newOriginX < fullOpenedWidth {
                    self.view.center = CGPointMake(self.view.center.x + deltaPoint.x, self.view.center.y)
                }
            case .WillClose:
                self.view.center = CGPointMake(self.view.frame.width / 2 + CGFloat(threshold), self.view.center.y)
            case .Closed:
                self.view.center = CGPointMake(self.view.frame.width / 2, self.view.center.y)
            case .WillOpen:
                self.view.center = CGPointMake(self.view.frame.width / 2 + CGFloat(threshold), self.view.center.y)
            case .Opened:
                self.view.center = CGPointMake(self.view.frame.width / 2 + fullOpenedWidth, self.view.center.y)
            }
        }
        // TODO: other directions
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let currentPoint = recognizer.translationInView(self.view)

        if let stateMachine = self.stateMachine {
            switch recognizer.state {
            case .Began, .Changed:
                stateMachine.keepMoving(currentPoint)
            default:
                stateMachine.stopMoving()
            }
        }
    }
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue) {
        print("unwindToMenu")
    }
    
}

