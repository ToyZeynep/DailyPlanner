//
//  LocalNotificationManager.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation

protocol LocalNotificationManagerProtocol: AnyObject{
    func addWillNotify(index: Int)
    func removeWillNotify(identifier: [String])
}
