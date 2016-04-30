//
//  FirstViewController.swift
//  PillTracker
//
//  Created by Lee Kangsik Kevin on 4/28/16.
//  Copyright © 2016 Lee Kangsik Kevin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func jump2Tap(sender: AnyObject) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func jump3Tap(sender: AnyObject) {
        tabBarController?.selectedIndex = 2
    }
    @IBAction func jump4Tap(sender: AnyObject) {
        tabBarController?.selectedIndex = 3
    }
}

