//
//  ViewController.swift
//  ElasticMotion
//
//  Created by jongwon woo on 2016. 3. 14..
//  Copyright © 2016년 jongwonwoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let stateMachine = ElasticMotionStateMachine(10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print("\(stateMachine.criticalPoint)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

