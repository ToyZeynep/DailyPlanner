//
//  CoreDataManager.swift
//  DailyPlanner
//
//  Created by MacOS on 12.02.2022.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject{
    func addPlan(completionTime: Date, name: String, details: String, isComplete: Bool, priority: String , willNotify: Bool , category: String)
    func removePlan(object: Plan?)
    func getPlanList(completion: @escaping ((Result<[Plan], Error>) -> Void))
    func updateIsComplete(object: Plan)
    func updateWillNotify(object: Plan)
}
