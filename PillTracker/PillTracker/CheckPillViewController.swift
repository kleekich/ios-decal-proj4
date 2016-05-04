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


class CheckPillViewController: UIViewController, NSXMLParserDelegate {
    var eventStore: EKEventStore!
    var pillName: String!
    var interactionWith: String!
    var interactionDesc: String!
    var status: String!
    var desc: String!
    
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var textFieldPillName: UITextField!
    @IBOutlet weak var labelInteractionWith: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    

    
    @IBAction func checkButtonClicked(sender: AnyObject) {
        beginParsing()
        gettingInteractions()
        
        NSLog("----------IN PREPARE--------------------------")
        NSLog("\(self.interactionWith)")
        NSLog("\(self.interactionDesc)")
        NSLog("------------------------------------")

        self.view.endEditing(true)
        //textFieldPillName.text = ""
  
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.eventStore = EKEventStore()
        
        
        
    }
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    
    
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://rxnav.nlm.nih.gov/REST/rxcui?name=\(textFieldPillName.text!)"))!)!
        parser.delegate = self
        parser.parse()
        //tbData!.reloadData()
    }
   
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("rxnormId")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
           
        }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if element.isEqualToString("rxnormId") {
            title1.appendString(string)
         
        } else if element.isEqualToString("pubDate") {
            date.appendString(string)
        }
    }
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqualToString("rxnormId") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "rxnormId")
               
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date")
            }
            posts.addObject(elements)
        }
    }

    
    
    
    
    
    
    
    
    //MARK: - REST calls
    // This makes the GET call to httpbin.org. It simply gets the IP address and displays it on the screen.
    func gettingInteractions() {
        
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
                    
                    var groupJSON = readableJSON["interactionTypeGroup"]
                    var typeElementJSON = groupJSON[0]
                    var typeJSON = typeElementJSON["interactionType"][0]
                    var interactionPairJSON = typeJSON["interactionPair"][0]//can have serveral reactions
                    var interactionConceptJSON = interactionPairJSON["interactionConcept"][1]
                    self.interactionWith = interactionConceptJSON["minConceptItem"]["name"].rawString() as String!

                    self.interactionDesc = interactionPairJSON["description"].rawString() as String!

                   
                    NSLog("------------------------------------")
                    NSLog("\(self.interactionWith)")
                    NSLog("\(self.interactionDesc)")
                    NSLog("------------------------------------")
 
                    
                    
                    /*core
                    
                    var jsonArray = readableJSON["interactionTypeGroup"][0]["interactionType"][0]["interactionPair"]
                    var numArr = jsonArray.count
                   
                    self.interactionWith = []
                    for i in 0...numArr-1{
                        var name = readableJSON["interactionTypeGroup"][0]["interactionType"][0]["interactionPair"][i]["interactionConcept"][1]["minConceptItem"]["name"].rawString() as String!
                        print(name)
                        self.interactionWith.append(name!)
                        
                    }
                    */
                   /*
  
                    var groupJSON = readableJSON["interactionTypeGroup"]
                    var typeElementJSON = groupJSON[0]
                    var typeJSON = typeElementJSON["interactionType"][0]
                    var interactionPairJSON = typeJSON["interactionPair"][0]//can have serveral reactions
                    var interactionConceptJSON = interactionPairJSON["interactionConcept"][0]
                    //var name = interactionConceptJSON["minConceptItem"]["name"]
                    interactionPairJSON["description"]
 
                    
                    interactionWith = readableJSON["interactionTypeGroup"][0]["interactionType"][0]["interactionPair"][0]["interactionConcept"][0]["minConceptItem"]["name"]
                    
                    NSLog("------------------------------------")
                    NSLog("\(name)")
                    NSLog("------------------------------------")
                    */
                    
                // Update the label
                    
                    
                    self.performSelectorOnMainThread("updateLabelInteraction:", withObject: self.interactionWith, waitUntilDone: false)
                    self.performSelectorOnMainThread("updateLabelDesc:", withObject: self.interactionDesc, waitUntilDone: false)
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
        addPillViewController.pillName = textFieldPillName!.text
        //addPillViewController.desc = self.interactionDesc
        //addPillViewController.status = status
        //addPillViewController.desc = self.desc
        
    }
    //MARK: - Methods to update the UI immediately
    func updateLabelInteraction(text: String) {
        self.labelInteractionWith.text = text
    }
    func updateLabelDesc(text: String) {
        self.textViewDescription.text = text
    }
    
 
    
    
    
}
