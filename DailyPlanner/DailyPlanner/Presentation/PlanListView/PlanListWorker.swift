//
//  PlanListWorker.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerListWorkerProtocol: AnyObject{
    func removePlan(object: Plan?)
    func getPlanList(completion: @escaping ((Result<[Plan], Error>) -> Void))
    func updateIsComplete(object: Plan)
    func updateWillNotify(object: Plan)
}

final class PlanListWorker: CoreDataManagerListWorkerProtocol  {
    
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
    
    func getPlanList(completion: @escaping ((Result<[Plan], Error>) -> Void)) {
        
        do {
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            var models = try managedContext.fetch(Plan.fetchRequest())
            completion(.success(models))
        } catch {
            completion(.failure(error))
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
