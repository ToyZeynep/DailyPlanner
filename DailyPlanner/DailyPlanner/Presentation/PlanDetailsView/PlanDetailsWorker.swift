//
//  PlanDetailsWorker.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import CoreData
import UIKit

final class PlanDetailsWorker:  CoreDataManagerProtocol , NotificationManagerProtocol {
  
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
    func removeNotification(name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(name), object: nil)
    }
    
    func removePlan(object: Plan?) {
        let  managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(object!)
        do {
            try managedContext.save()
        } catch {
            print("error")
        }
    }
    
    func sendNotification(name: String) {
        NotificationCenter.default.post(name: NSNotification.Name(name), object: nil)
    }
    
    func getPlanList(completion: @escaping ((Result<[Plan], Error>) -> Void)) {
        
    }

    func getNotification(name: String) {
        
    }
    
    func updateIsComplete(object: Plan) {
        
    }
    
    func updateWillNotify(object: Plan) {
        
    }
    
}


