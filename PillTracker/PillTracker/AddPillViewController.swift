//
//  AddPillViewController.swift
//  PillTracker
//
//  Created by Lee Kangsik Kevin on 5/1/16.
//  Copyright © 2016 Lee Kangsik Kevin. All rights reserved.
//

import UIKit
import EventKit

class AddPillViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    // Properties
    var eventStore: EKEventStore!
    var datePicker: UIDatePicker!
    
    @IBOutlet weak var textFieldPillName: UITextField!
    @IBOutlet weak var pickerViewCategory: UIPickerView!
    @IBOutlet weak var textFieldHours: UITextField!
    @IBOutlet weak var textFieldFirstAt: UITextField!
    @IBOutlet weak var buttonCheck: UIButton!
    
    @IBOutlet weak var textFieldNumPills: UITextField!
    
    let pickerData = ["Medicine","Supplement"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: "addDate", forControlEvents: UIControlEvents.ValueChanged)
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        textFieldFirstAt.inputView = datePicker
        self.pickerViewCategory.dataSource = self;
        self.pickerViewCategory.delegate = self;
        //reminderTextView.becomeFirstResponder()
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveNewReminder(sender: AnyObject) {
        //Pill
        /*
        pillMgr.addPill(textFieldPillName.text!, desc: txtDesc.text!, createdAt: NSDate(), completedAt: nil)
        self.view.endEditing(true)
        txtTask.text = ""
        txtDesc.text = ""

        */
        
        //Reminder
        let reminder = EKReminder(eventStore: self.eventStore)
        //reminder.title = reminderTextView.text
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let dueDateComponents = appDelegate.dateComponentFromNSDate(self.datePicker.date)
        reminder.dueDateComponents = dueDateComponents
        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
        do {
            try self.eventStore.saveReminder(reminder, commit: true)
            dismissViewControllerAnimated(true, completion: nil)
        }catch{
            print("Error creating and saving new reminder : \(error)")
        }
    }
    
    func addDate(){
        self.textFieldFirstAt.text = self.datePicker.date.description
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
  
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
