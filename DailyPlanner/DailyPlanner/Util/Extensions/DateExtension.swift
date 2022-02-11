//
//  DateExtension.swift
//  DailyPlanner
//
//  Created by MacOS on 11.02.2022.
//

import Foundation

extension Date
{
    var dayInWeek : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self as Date)
    }
    
    var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self as Date)
    }
    
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self as Date)
    }
    
    var dateAsPrettyString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd<>MM<>yyyy"
        return formatter.string(from: self as Date)
    }
}
