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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let menuViewWidth = Float(100.0)
        self.transition = ElasticTransition(presentedViewController: self, presentingViewWidth: menuViewWidth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        self.transition?.handlePanGesture(recognizer)
    }
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue) {
        print("unwindToMenu")
    }
    
}

