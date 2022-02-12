//
//  PlanDetailsWorker.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import CoreData
import UIKit

protocol CoreDataManagerDetailsWorkerProtocol: AnyObject{
    func addPlan(completionTime: Date, name: String, details: String, isComplete: Bool, priority: String , willNotify: Bool , category: String)
}

final class PlanDetailsWorker:  CoreDataManagerDetailsWorkerProtocol{
    
    func addPlan(completionTime: Date, name: String, details: String, isComplete: Bool, priority: String, willNotify: Bool, category: String) {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var plan = Plan(context: managedContext)
        plan.completionTime = completionTime
        plan.name = name
        plan.details = details
        plan.isComplete = isComplete
        plan.priority = priority
        plan.willNotify = willNotify
        plan.category = category
        
        do {
            try managedContext.save()
            print("saved")
        }catch{
            print("error")
        }
    }
}


