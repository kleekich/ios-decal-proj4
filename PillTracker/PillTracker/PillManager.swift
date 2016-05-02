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
    var desc = "Un-Described"
    /*
    var category: String
    var numPills: Int
    var duration: Int
    var firstTakeAt: NSDate?
    var schedule: [NSDate?]
    var pillsTook: Int
    */
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
    func addPill(name: String, desc: String){
        medicines.append(pill(name: name ,desc: desc))
    }
    
    /*
    func addPill(name: String, category: String, numPills: Int, duration: Int, hr: Int, min: Int, isAM: Bool, isNow: Bool){
        //initialize pill
        var schedule: [NSDate] = []
        
        
        if(category == "Medicine"){
            
            
            
            medicines.append()
        }
        
        
    }
    
    func deleteTask(taskDeleted: Int!){
        tasks.removeAtIndex(taskDeleted)
    }
    
    func completeTask(taskCompleted: Int!){
        print("Completed a task!")
        tasks[taskCompleted].completedAt = NSDate()
        tasksCompleted.append(tasks[taskCompleted])
        
    }
 */
    
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


}
