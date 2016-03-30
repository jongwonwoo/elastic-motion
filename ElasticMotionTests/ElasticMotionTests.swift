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

    enum ExpectationStateOfOpeningToRight: String {
        case MayOpen
        case WillOpen
        case Opened
        case MayOpenThenClosed
        //TODO: MayClose, MayCloseThenOpened, WillClose, Closed
    }
    
    enum ExpectationStateOfOpeningToLeft: String {
        case MayOpen
        case WillOpen
        case Opened
        case MayOpenThenClosed
        //TODO: MayClose, MayCloseThenOpened, WillClose, Closed
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.stateMachine = nil
        
        super.tearDown()
    }
    
    func createStateMachine(direction: ElasticMotionDirection) {
        switch direction {
        case .Right:
            self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Right, threshold: 50.0, vibrationSec: vibrationSec)
        case .Left:
            self.stateMachine = ElasticMotionStateMachine(ElasticMotionDirection.Left, threshold: 50.0, vibrationSec: vibrationSec)
        default:
            break
        }
        
        self.stateMachine?.delegate = self
    }
    
    //MARK: - Right of direction
    func testOpenToRightMayOpen() {
        self.createStateMachine(.Right)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToRight.MayOpen.rawValue)
        
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
        self.createStateMachine(.Right)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToRight.MayOpenThenClosed.rawValue)
        
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
        self.createStateMachine(.Right)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToRight.WillOpen.rawValue)

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
        self.createStateMachine(.Right)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToRight.Opened.rawValue)
        
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
    
    //MARK: - Left of direction
    func testOpenToLeftMayOpen() {
        self.createStateMachine(.Left)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToLeft.MayOpen.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(100, 10))
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpenToLeftMayOpenThenStop() {
        self.createStateMachine(.Left)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToLeft.MayOpenThenClosed.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(100, 10))
            stateMachine.stopMoving()
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpenToLeftWillOpen() {
        self.createStateMachine(.Left)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToLeft.WillOpen.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(100, 10))
            stateMachine.keepMoving(CGPointMake(90, 10))
            stateMachine.keepMoving(CGPointMake(80, 10))
            stateMachine.keepMoving(CGPointMake(49, 10))
            
            waitForExpectationsWithTimeout(0.1) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func testOpenToLeftOpened() {
        self.createStateMachine(.Left)
        
        self.expectation = expectationWithDescription(ExpectationStateOfOpeningToLeft.Opened.rawValue)
        
        if let stateMachine = self.stateMachine {
            stateMachine.keepMoving(CGPointMake(100, 10))
            stateMachine.keepMoving(CGPointMake(90, 10))
            stateMachine.keepMoving(CGPointMake(80, 10))
            stateMachine.keepMoving(CGPointMake(49, 10))
            
            waitForExpectationsWithTimeout(vibrationSec * 1.01) { error in
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }
        }
    }

    
    //MARK: elasticMotionStateMachine delegate
    func elasticMotionStateMachine(stateMachine: ElasticMotionStateMachine, didChangeState state: ElasticMotionState, deltaPoint: CGPoint) {
        if (self.expectation?.description == ExpectationStateOfOpeningToRight.MayOpen.rawValue) {
            if (state == ElasticMotionState.MayOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToRight.MayOpenThenClosed.rawValue) {
            if (state == ElasticMotionState.Closed) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToRight.WillOpen.rawValue) {
            if (state == ElasticMotionState.WillOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToRight.Opened.rawValue) {
            if (state == ElasticMotionState.Opened) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToLeft.MayOpen.rawValue) {
            if (state == ElasticMotionState.Closed) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToLeft.MayOpenThenClosed.rawValue) {
            if (state == ElasticMotionState.Closed) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToLeft.WillOpen.rawValue) {
            if (state == ElasticMotionState.WillOpen) {
                self.expectation?.fulfill()
            }
        } else if (self.expectation?.description == ExpectationStateOfOpeningToLeft.Opened.rawValue) {
            if (state == ElasticMotionState.Opened) {
                self.expectation?.fulfill()
            }
        }
    }
    
}
