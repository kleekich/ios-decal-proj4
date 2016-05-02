//
//  SecondTableViewController.swift
//  PillTracker
//
//  Created by Lee Kangsik Kevin on 4/28/16.
//  Copyright © 2016 Lee Kangsik Kevin. All rights reserved.
//

import UIKit
import EventKit

class SecondTableViewController: UITableViewController{
    var eventStore: EKEventStore!
    var reminders: [EKReminder]!
    var selectedReminder: EKReminder!

    
    @IBOutlet var tableViewMedicine: UITableView!
    
    
 
    
    override func viewWillAppear(animated: Bool) {
        // 1
        print("viewWillAppear")
        self.eventStore = EKEventStore()
        self.reminders = [EKReminder]()
        self.eventStore.requestAccessToEntityType(EKEntityType.Reminder) { (granted: Bool, error: NSError?) -> Void in
            
            if granted{
                // 2
                let predicate = self.eventStore.predicateForRemindersInCalendars(nil)
                self.eventStore.fetchRemindersMatchingPredicate(predicate, completion: { (reminders: [EKReminder]?) -> Void in
                    self.reminders = reminders
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableViewMedicine.reloadData()
                    }
                })
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }
    }
    
    override func viewDidLoad() {
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func editTable(sender: AnyObject) {
        tableViewMedicine.editing = !tableViewMedicine.editing
        if tableView.editing{
            tableView.setEditing(true, animated: true)
        }else{
            tableView.setEditing(false, animated: true)
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Which segue is triggered, react accordingly
        if segue.identifier == "ShowReminderDetails"{
            /*
            let reminderDetailsVC = segue.destinationViewController as! ReminderDetails
            reminderDetailsVC.reminder = self.selectedReminder
            reminderDetailsVC.eventStore = eventStore
            */
        }else{
            let nav = segue.destinationViewController as! UINavigationController
            let addPillViewController = nav.topViewController as! AddPillViewController
            
            addPillViewController.eventStore = eventStore
        }
    }
    

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle , reuseIdentifier: "reminderCell")
            let reminder:EKReminder! = self.reminders![indexPath.row]
            cell.textLabel?.text = reminder.title
            let formatter:NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let dueDate = reminder.dueDateComponents?.date{
                cell.detailTextLabel?.text = formatter.stringFromDate(dueDate)
            }else{
                cell.detailTextLabel?.text = "N/A"
            }
            print("Hi I am a cell")
            return cell
    }

    
 
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let reminder: EKReminder = reminders[indexPath.row]
        do{
            try eventStore.removeReminder(reminder, commit: true)
            self.reminders.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }catch{
            print("An error occurred while removing the reminder from the Calendar database: \(error)")
        }
    }
    
    //MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        self.selectedReminder = self.reminders[indexPath.row]
        self.performSegueWithIdentifier("ShowReminderDetails", sender: self)
    }
    
    @IBAction func unwindToSecondTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "save" {
        }
        /*
        if let avc = segue.sourceViewController as? SecondTableViewController {
            //taskMgr.addTask(avc.txtTask.text!, desc: avc.txtDesc.text!, createdAt: NSDate(), completedAt: nil)
            
        }
        */
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
