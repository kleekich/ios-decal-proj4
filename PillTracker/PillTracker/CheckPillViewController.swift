//
//  CheckPillViewController.swift
//  PillTracker
//
//  Created by Lee Kangsik Kevin on 5/2/16.
//  Copyright © 2016 Lee Kangsik Kevin. All rights reserved.
//


import UIKit
import EventKit


class CheckPillViewController: UIViewController {
    var eventStore: EKEventStore!
    var pillName: String!
    var status: String!
    var desc: String!
    
    @IBOutlet weak var textFieldPillName: UITextField!
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.eventStore = EKEventStore()
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Which segue is triggered, react accordingly
        let nav = segue.destinationViewController as! UINavigationController
        let addPillViewController = nav.topViewController as! AddPillViewController
        
        addPillViewController.eventStore = eventStore
        addPillViewController.pillName = textFieldPillName.text!
        addPillViewController.status = status
        addPillViewController.desc = desc
        
    }
    
    
    
    
}
