//
//  ElasticMotionTests.swift
//  ElasticMotionTests
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import XCTest
@testable import ElasticMotion

class ElasticMotionStateMachineForTopDirectionTests: XCTestCase, ElasticMotionStateMachineDelegate {
    var stateMachine: ElasticMotionStateMachine?
    let vibrationSec = 0.5
    
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.createStateMachine()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.stateMachine = nil
        
        super.tearDown()
    }
    
    func createStateMachine() {
        self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Top, threshold: 50.0, vibrationSec: vibrationSec)
        self.stateMachine?.delegate = self
    }
    
    func testMayOpen() {
        self.expectation = expectationWithDescription(ElasticMotionStateMachineExpectationState.MayOpen.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 100))
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testMayOpenThenStop() {
        self.expectation = expectationWithDescription(ElasticMotionStateMachineExpectationState.MayOpenThenClosed.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 100))
            stateMachine.stopMoving()
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testWillOpen() {
        self.expectation = expectationWithDescription(ElasticMotionStateMachineExpectationState.WillOpen.rawValue)

        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 100))
            stateMachine.keepMoving(CGPointMake(0, 80))
            stateMachine.keepMoving(CGPointMake(0, 60))
            stateMachine.keepMoving(CGPointMake(0, 49))
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpened() {
        self.expectation = expectationWithDescription(ElasticMotionStateMachineExpectationState.Opened.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(0, 100))
            stateMachine.keepMoving(CGPointMake(0, 80))
            stateMachine.keepMoving(CGPointMake(0, 60))
            stateMachine.keepMoving(CGPointMake(0, 49))
            
            waitForExpectationsWithTimeout(vibrationSec * 1.01) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //MARK: elasticMotionStateMachine delegate
    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState state: ElasticMotionState, deltaPoint: CGPoint) {
        if (self.expectation?.description == ElasticMotionStateMachineExpectationState.MayOpen.rawValue) {
            if (state == ElasticMotionState.MayOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ElasticMotionStateMachineExpectationState.MayOpenThenClosed.rawValue) {
            if (state == ElasticMotionState.Closed) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ElasticMotionStateMachineExpectationState.WillOpen.rawValue) {
            if (state == ElasticMotionState.WillOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ElasticMotionStateMachineExpectationState.Opened.rawValue) {
            if (state == ElasticMotionState.Opened) {
                self.expectation?.fulfill()
            }
        }
    }
    
}
