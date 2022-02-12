//
//  planDetailsEnum.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation

enum Priority: String {
    case high = "high"
    case medium = "medium"
    case low = "low"
}

enum Category: String {
    case home = "home"
    case business = "business"
    case shopping = "shopping"
    case feelGood = "feelGood"
}

enum Sort: String {
    case alphabetical1 = "A-Z"
    case alphabetical2 = "Z-A"
    case date1 = "Increasing by Date"
    case date2 =  "Descending by Date"
    case cancel = "Deselect"
}

enum Filter: String {
    
    case categori = "Categori"
    case isComplete = "IsComplete"
    case priority = "Priority"
    case willNotify = "WillNotify"
    case cancel = "Deselect"
    
}

enum IsComplete: String {
    case completed = "completed"
    case inCompleted = "inCompleted"
}

enum WillNotify: String {
    case willNotify = "willNotify"
    case willNotNotify = "willNotNotify"
}
