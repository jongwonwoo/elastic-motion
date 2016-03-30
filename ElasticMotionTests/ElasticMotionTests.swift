//
//  ElasticMotionTests.swift
//  ElasticMotionTests
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import XCTest
@testable import ElasticMotion

class ElasticMotionTests: XCTestCase, ElasticMotionStateMachineDelegate {
    var stateMachine: ElasticMotionStateMachine?
    let vibrationSec = 0.5
    
    var expectation: XCTestExpectation?
    
    let openToRight_MayOpen = "openToRight_MayOpen"
    let openToRight_WillOpen = "openToRight_WillOpen"
    let openToRight_Opened = "openToRight_Opened"
    let openToRight_MayOpenThenStop = "openToRight_MayOpenThenStop"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.stateMachine = nil
        
        super.tearDown()
    }
    
    func testOpenToRightMayOpen() {
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, threshold: 50.0, vibrationSec: vibrationSec)
        self.stateMachine?.delegate = self
        
        self.expectation = expectationWithDescription(openToRight_MayOpen)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 10))
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpenToRightMayOpenThenStop() {
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, threshold: 50.0, vibrationSec: vibrationSec)
        self.stateMachine?.delegate = self
        
        self.expectation = expectationWithDescription(openToRight_MayOpenThenStop)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 10))
            stateMachine.stopMoving()
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpenToRightWillOpen() {
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, threshold: 50.0, vibrationSec: vibrationSec)
        self.stateMachine?.delegate = self
        
        self.expectation = expectationWithDescription(openToRight_WillOpen)

        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 10))
            stateMachine.keepMoving(CGPointMake(20, 10))
            stateMachine.keepMoving(CGPointMake(30, 10))
            stateMachine.keepMoving(CGPointMake(51, 10))
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpenToRightOpened() {
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, threshold: 50.0, vibrationSec: vibrationSec)
        self.stateMachine?.delegate = self
        
        self.expectation = expectationWithDescription(openToRight_Opened)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 10))
            stateMachine.keepMoving(CGPointMake(20, 10))
            stateMachine.keepMoving(CGPointMake(30, 10))
            stateMachine.keepMoving(CGPointMake(51, 10))
            
            waitForExpectationsWithTimeout(vibrationSec * 1.01) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState state: ElasticMotionState, deltaPoint: CGPoint) {
        if (self.expectation?.description == openToRight_MayOpen) {
            if (state == ElasticMotionState.MayOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == openToRight_WillOpen) {
            if (state == ElasticMotionState.WillOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == openToRight_Opened) {
            if (state == ElasticMotionState.Opened) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == openToRight_MayOpenThenStop) {
            if (state == ElasticMotionState.Closed) {
                self.expectation?.fulfill()
            }
        }
    }
    
}
