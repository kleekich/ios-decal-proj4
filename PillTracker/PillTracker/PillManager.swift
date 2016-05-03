//
//  PillManager.swift
//  PillTracker
//
//  Created by Lee Kangsik Kevin on 4/30/16.
//  Copyright © 2016 Lee Kangsik Kevin. All rights reserved.
//

import UIKit
import EventKit

var pillMgr: PillManager = PillManager()

struct pill{
    var name = "Un-named"
    var category: String
    var numPills: Int
    var duration: Int
    var pillsTook: Int
    var alarmTimes: [NSDate!]
    var nextAlarmIndex: Int
    var timeLeft: String
    var reminder: EKReminder
    var reactionWith: [String!]
    
}

struct food{
    var name: String = "Un-named"
    var desc: String = "Un-Described"
    var reactionWith: pill
}


class PillManager: NSObject {
    
    var medicines = [pill]()
    //var supplements = [pill]()
    //var foodsToAvoid = [food]()
    /*
    func addPill(name: String, desc: String){
        medicines.append(pill(name: name ,desc: desc))
    }
     */
    
    
    func addPill(name: String, category: String, numPills: Int, duration: Int, pillsTook: Int, alarmTimes: [NSDate!], nextAlarmIndex: Int, timeLeft: String, reminder: EKReminder)-> pill{
        //initialize pill
        
        //calculate pills took
        //var pillsTookForNow: Int = lastAlarmIndex-1
        //let p = pill(name:name, category: category, numPills: numPills, duration: duration, pillsTook: pillsTookForNow, alarmTimes: alarmTimes, lastAlarmIndex: lastAlarmIndex)
        
        
        let p = pill(name:name, category: category, numPills: numPills,  duration: duration, pillsTook: pillsTook,alarmTimes: alarmTimes, nextAlarmIndex: nextAlarmIndex, timeLeft: timeLeft, reminder: reminder)
        
        if(category == "Medicine"){
            medicines.append(p)
        }
        return p
        
        
    }
    
    
    
    func deleteMedicine(pillDeleted: Int!){
        medicines.removeAtIndex(pillDeleted)
    }
    
    func getNewTimeLeft(){
        for i in 0...medicines.count-1{
            var m = medicines[i]
            var nextAlarm = m.alarmTimes[m.nextAlarmIndex]
            //if alarm is fired
            if nextAlarm.isLessThanDate(NSDate()){
                medicines[i].nextAlarmIndex+=1
                nextAlarm = m.alarmTimes[m.nextAlarmIndex]
                let alarm: EKAlarm = EKAlarm(absoluteDate: nextAlarm)
                m.reminder.addAlarm(alarm)
                medicines[i].pillsTook+=1
                
            }
            
            medicines[i].timeLeft = nextAlarm.offsetFrom(NSDate())
        }
    }
    
    func setTimeLeft(timeLeft: String){
        
    }
    /*
    func completeTask(taskCompleted: Int!){
        print("Completed a task!")
        medicines[medicineCompleted].completedAt = NSDate()
        medicineCompleted.append(medicines[taskCompleted])
        
    }
 
    
    func countCompletedTasks() -> Int{
        let currentTime: NSDate = NSDate()
        var timeInterval: Double = 0.0
        var count = 0
        /*
        for task in tasksCompleted{
            timeInterval = currentTime.timeIntervalSinceDate(task.createdAt!);
            if timeInterval<86400{
                count++
            }
        }
 */
        return count;
    }
*/

}
