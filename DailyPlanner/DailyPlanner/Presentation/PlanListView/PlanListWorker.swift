//
//  PlanListWorker.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import Foundation
import UIKit
import CoreData

final class PlanListWorker: CoreDataManagerProtocol  {
    func addPlan(completionTime: Date, name: String, details: String, isComplete: Bool, priority: String, willNotify: Bool, category: String) {
    }
    
    func removePlan(object: Plan?) {
        let  managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            print(object?.name as Any)
        managedContext.delete(object!)
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print("error")
        }
    }
    
    func updateIsComplete(object: Plan) {
        let  managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if object.isComplete == true{
            object.isComplete = false
        }else {
            object.isComplete = true
        }
        print(object.isComplete)
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print("error")
        }
    }
    
    func getPlanList(completion: @escaping ((Result<[Plan], Error>) -> Void)) {
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var models = try context.fetch(Plan.fetchRequest())
            completion(.success(models))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func updateWillNotify(object: Plan){
        
        let  managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
       
        if object.willNotify == true{
            object.willNotify = false
        }else {
            object.willNotify = true
        }
   
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print("error")
        }
    }
  

}
