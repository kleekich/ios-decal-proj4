//
//  CheckPillViewController.swift
//  PillTracker
//
//  Created by Lee Kangsik Kevin on 5/2/16.
//  Copyright © 2016 Lee Kangsik Kevin. All rights reserved.
//


import UIKit
import EventKit
import SwiftyJSON


class CheckPillViewController: UIViewController {
    var eventStore: EKEventStore!
    var pillName: String!
    var status: String!
    var desc: String!
    
    @IBOutlet weak var textFieldPillName: UITextField!
    
    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var postResultLabel: UILabel!

    
    override func viewWillAppear(animated: Bool) {
        
        self.eventStore = EKEventStore()
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateIP()
        
    }
    
    //MARK: - REST calls
    // This makes the GET call to httpbin.org. It simply gets the IP address and displays it on the screen.
    func updateIP() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let postEndpoint: String = "https://rxnav.nlm.nih.gov/REST/interaction/interaction.json?rxcui=341248"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let dataString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    // Print what we got from the call
                    //print(ipString)
                    
                    // Parse the JSON to get the IP
                
                    let url = NSURL(string: postEndpoint)
                    let jsonData = NSData(contentsOfURL: url!) as NSData!
                    let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
                    /*
                    var groupJSON = readableJSON["interactionTypeGroup"]
                    var typeElementJSON = groupJSON[0]
                    var typeJSON = typeElementJSON["interactionType"][0]
                    var interactionPairJSON = typeJSON["interactionPair"][0]//can have serveral reactions
                    var interactionConceptJSON = interactionPairJSON["interactionConcept"][1]
                    var interactionItemName = interactionConceptJSON["minConceptItem"]["name"]
                    var interactionDesc = interactionPairJSON["description"]
 
                    NSLog("------------------------------------")
                    NSLog("\(interactionItemName)")
                    NSLog("------------------------------------")
  */
                    var jsonArray = readableJSON["interactionTypeGroup"][0]["interactionType"][0]["interactionPair"]
                    var numArr = jsonArray.count
                   
                    var names:[String] = []
                    for i in 0...numArr-1{
                        var name = readableJSON["interactionTypeGroup"][0]["interactionType"][0]["interactionPair"][i]["interactionConcept"][1]["minConceptItem"]["name"].rawString() as String!
                        print(name)
                        names.append(name!)
                        
                    }
                    
  /*
                    var groupJSON = readableJSON["interactionTypeGroup"]
                    var typeElementJSON = groupJSON[0]
                    var typeJSON = typeElementJSON["interactionType"][0]
                    var interactionPairJSON = typeJSON["interactionPair"][0]//can have serveral reactions
                    var interactionConceptJSON = interactionPairJSON["interactionConcept"][0]
                    //var name = interactionConceptJSON["minConceptItem"]["name"]
                    
 
                    
                    var name = readableJSON["interactionTypeGroup"][0]["interactionType"][0]["interactionPair"][0]["interactionConcept"][0]["minConceptItem"]["name"]
 
                    NSLog("------------------------------------")
                    NSLog("\(name)")
                    NSLog("------------------------------------")
                    */
                    
                                        // Update the label
                    self.performSelectorOnMainThread("updateIPLabel:", withObject: self.desc, waitUntilDone: false)
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
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
    //MARK: - Methods to update the UI immediately
    func updateIPLabel(text: String) {
        self.ipLabel.text = "Your IP is " + text
    }
    
    func updatePostLabel(text: String) {
        self.postResultLabel.text = "POST : " + text
    }
    
    
    
    
}
