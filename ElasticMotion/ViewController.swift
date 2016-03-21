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
        
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, criticalPoint: 5.0, vibrationSec: 2.0)
        self.stateMachine?.delegate = self
        
        //TODO: add elasticmotionstatemachine test
        if let stateMachine = self.stateMachine {
            stateMachine.setPoint(CGPointMake(0, 0), delta:CGPointMake(1, 0))
            stateMachine.setPoint(CGPointMake(1, 0), delta:CGPointMake(1, 1))
            stateMachine.setPoint(CGPointMake(2, 1), delta:CGPointMake(3, 1))
            stateMachine.setPoint(CGPointMake(5, 0), delta:CGPointMake(1, 1))
            stateMachine.setPoint(CGPointMake(6, 0), delta:CGPointMake(3, 1))
            stateMachine.setPoint(CGPointMake(9, 0), delta:CGPointMake(1, 1))
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState: ElasticMotionState, deltaPoint: CGPoint) {
        print("\(didChangeState), \(deltaPoint)")
    }
}

