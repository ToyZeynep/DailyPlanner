//
//  PlanDetailsInteractor.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import Foundation
import UIKit
import CoreData
import McPicker

protocol PlanDetailsBusinessLogic: AnyObject {
    func fetchPlanDetails()
    func AddPlanDetails(completionTime: Date, name: String, details: String, isComplete: Bool , priority: String , willNotify: Bool , category: String)
    func alertAction(title: String , message: String , action: UIAlertAction)
    func alert(title: String , message: String)
}

protocol PlanDetailsDataStore: AnyObject {
    var plan: Plan? { get set }
}

protocol NotificationManagerPlanDetailsProtocol: AnyObject{
    func sendNotification(name: String)
}

class PlanDetailsInteractor: PlanDetailsBusinessLogic, PlanDetailsDataStore ,NotificationManagerPlanDetailsProtocol {
    
    var plan: Plan?
    var presenter: PlanDetailsPresentationLogic?
    var worker:  CoreDataManagerProtocol & NotificationManagerProtocol
    
    init(worker: CoreDataManagerProtocol & NotificationManagerProtocol) {
        self.worker = worker
    }
    
    func fetchPlanDetails() {
        self.presenter?.presentPlanDetails(response: .init(plan: plan))
    }
    
    func AddPlanDetails(completionTime: Date, name: String, details: String, isComplete: Bool, priority: String , willNotify : Bool , category: String) {
        worker.addPlan(completionTime: completionTime, name: name, details: details, isComplete: isComplete, priority: priority, willNotify: willNotify , category: category)
    }
        
    func alertAction(title: String, message: String, action: UIAlertAction) {
        presenter?.alertAction(title: title, message: message, action: action)
    }
    
    func alert(title: String, message: String) {
        presenter?.alert(title: title, message: message)
    }
    
     func sendNotification(name: String) {
        worker.sendNotification(name: name)
    }
}

