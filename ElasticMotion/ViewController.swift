//
//  ViewController.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var transition: ElasticTransition?
    @IBOutlet weak var directionSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.createElasticTransition(ElasticMotionDirection.Right)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createElasticTransition(direction: ElasticMotionDirection) {
        let menuViewWidth = Float(100.0)
        self.transition = ElasticTransition(presentedViewController: self, presentingViewWidth: menuViewWidth, direction: direction)
    }
    
    @IBAction func changeDirection(sender: AnyObject) {
        var direction = ElasticMotionDirection.Right
        
        let selectedIndex = self.directionSegment.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            direction = .Right
        case 1:
            direction = .Left
        case 2:
            direction = .Top
        case 3:
            direction = .Bottom
        default:
            break
        }
        
        self.createElasticTransition(direction)
    }
        
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        self.transition?.handlePanGesture(recognizer)
    }
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue) {
        print("unwindToMenu")
    }
    
}

