//
//  NotificationManager.swift
//  DailyPlanner
//
//  Created by MacOS on 12.02.2022.
//

import Foundation

protocol NotificationManagerProtocol: AnyObject{
    func sendNotification(name: String)
    func getNotification(name: String)
    func removeNotification(name: String)
}
