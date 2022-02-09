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
    case alfabetik1 = "A-Z"
    case alfabetik2 = "Z-A"
    case date1 = "Increasing by Date"
    case date2 =  "Descending by Date"
    case cancel = "Deselect"
}

enum Filter: String {
 
    case high = "high"
    case medium = "medium"
    case low = "low"
    case home = "1"
    case business = "2"
    case shopping = "3"
    case feelGood = "55"
    case completed = "completed"
    case inCompleted = "inCompleted"
    case cancel = "Deselect"
    
}

enum IsComplete: String {
    case completed = "completed"
    case inCompleted = "inCompleted"
}

