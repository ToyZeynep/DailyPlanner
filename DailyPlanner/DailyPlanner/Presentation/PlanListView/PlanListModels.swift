//
//  PlanListModels.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import CoreData
enum PlanList {
    
    enum Fetch {
        
        struct Request {
        }
        
        struct Response {
            var planList: [Plan]
        }
        
        struct ViewModel {
            var planList: [PlanList.Fetch.ViewModel.Plan?]

            struct Plan {
                var name: String?
                var completionTime: Date?
                var isComplete: Bool?
                var details: String?
                var priority: String?
                var willNotify: Bool?
                var category: String?
            }
        }
    }
}

