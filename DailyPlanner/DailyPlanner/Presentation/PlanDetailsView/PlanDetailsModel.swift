//
//  PlanDetailsModel.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import Foundation

enum PlanDetails {
    
    enum Fetch {
        
        struct Request {
            
        }
        
        struct Response {
            let plan: Plan?
        }
        
        struct ViewModel {
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

