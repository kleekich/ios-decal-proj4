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
    var selectedCategory: String!
    var pillName: String! = ""
    var status: String!
    var desc: String!
    
    @IBOutlet weak var labelPillName: UILabel!
    @IBOutlet weak var textFieldPillName: UITextField!
    @IBOutlet weak var pickerViewCategory: UIPickerView!
    @IBOutlet weak var textFieldHours: UITextField!
    @IBOutlet weak var textFieldFirstAt: UITextField!
    @IBOutlet weak var buttonCheck: UIButton!
    
    @IBOutlet weak var textFieldNumPills: UITextField!
    
    let pickerData = ["Medicine","Supplement"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPillName.text! = pillName
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(AddPillViewController.addDate), forControlEvents: UIControlEvents.ValueChanged)
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        textFieldFirstAt.inputView = datePicker
        self.pickerViewCategory.dataSource = self;
        self.pickerViewCategory.delegate = self;
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // 1
        print("viewWillAppear")
        
        
        
        
    }

    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveNewReminder(sender: AnyObject) {
        
        let numPills = Int(textFieldNumPills.text!)!
        let duration =  Int(textFieldHours.text!)!
        
        //Making Alarm Array for new pill
        var alarmTime = datePicker.date
        var alarmArray: [NSDate] = [alarmTime]
        if numPills > 1{
            for _ in 1...numPills-1{
                alarmTime = alarmTime.addHours(duration)
                alarmArray.append(alarmTime)
            }
        }
        //Getting next Alarm & next Alarm index
        var nextAlarm: NSDate = alarmArray[0]
        var nextAlarmIndex: Int = 0
        var pillsTook: Int = 0
        for i in 0...alarmArray.count-1{
            //if alarm Time is later than current time, this is the next alarm
            if alarmArray[i].isGreaterThanDate(NSDate()){
                nextAlarm = alarmArray[i]
                nextAlarmIndex = i
                break;
            }
            pillsTook+=1
            
        }
        //timeLeft for next Alarm
        let timeLeft = nextAlarm.offsetFrom(NSDate())
        
        ////Create a Reminder
        let reminder = EKReminder(eventStore: self.eventStore)
        reminder.title = self.pillName

        
        //Create a Pill
        let pill = pillMgr.addPill(self.pillName, category: selectedCategory, numPills: numPills, duration: duration, pillsTook: pillsTook, alarmTimes: alarmArray, nextAlarmIndex: nextAlarmIndex, timeLeft: timeLeft, reminder: reminder)
        
        
        //Add Recurrence Rule for daily
        let recRule: EKRecurrenceRule = EKRecurrenceRule(recurrenceWithFrequency: EKRecurrenceFrequency.Daily ,interval: 1,end: nil)
        reminder.addRecurrenceRule(recRule)
        
        //Setting Alarms with reminder
        for time in pill.alarmTimes{
            let alarm: EKAlarm = EKAlarm(absoluteDate: time)
            reminder.addAlarm(alarm)
        }
        
        
        /*
         let alarm = EKAlarm(absoluteDate: timeInterval)
         var interval: NSTimeInterval = Double(2)
         alarm = EKAlarm(absoluteDate: NSDate().dateByAddingTimeInterval(interval))
         reminder.addAlarm(alarm)
         */
        
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
        
        self.view.endEditing(true)
        textFieldNumPills.text = ""
        textFieldHours.text = ""
        textFieldFirstAt.text = ""
        
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
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedCategory = pickerData[row]
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
