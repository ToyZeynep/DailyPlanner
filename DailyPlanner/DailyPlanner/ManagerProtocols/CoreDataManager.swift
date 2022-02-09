//
//  CoreDataManager.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import CoreData

protocol DataManagerProtocol: AnyObject{
    func addPlan(completionTime: Date, name: String, details: String, isComplete: Bool, priority: String , willNotify: Bool , category: String)
    func removePlan(object: Plan?)
    func getPlanList(completion: @escaping ((Result<[Plan], Error>) -> Void))
    func updatePlan(object: Plan)
}
