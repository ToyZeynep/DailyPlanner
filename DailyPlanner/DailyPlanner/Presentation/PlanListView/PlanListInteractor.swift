//
//  PlanListInteractor.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import UIKit
import CoreData

protocol PlanListBusinessLogic: AnyObject {
    func fetchPlanList()
    func getNotification(name: String)
    func removePlan(index: Int)
    func updateIsComplete(index: Int)
    func addWillNotify(index: Int)
    func updateWillNotify(index: Int)
    func removeWillNotify(identifier: [String])
    func alertAction(title: String, message: String, action: UIAlertAction)
    func alert(title: String, message: String)

}

protocol PlanListDataStore: AnyObject {
    var planList: [Plan]? { get }
}

class PlanListInteractor: PlanListBusinessLogic, PlanListDataStore , NotificationManagerProtocol , LocalNotificationManagerProtocol{

    var planList: [Plan]?
    var presenter: PlanListPresentationLogic?
    var worker: PlanListWorker
    init(worker: PlanListWorker) {
        self.worker = worker
    }
    func fetchPlanList() {
        worker.getPlanList() { [weak self] result in
            switch result {
            case .success(let response):
                self?.planList = response
                guard let planList = self?.planList else { return }
                self?.presenter?.presentPlan(response: PlanList.Fetch.Response(planList: planList))
            case .failure(let error):
                print("error")
            }
        }
    }
    
    func addNotifications(indexValue: Int) {
         
    }
    
    func removePlan(index: Int) {
        worker.removePlan(object: planList![index])
    }
    
    func getNotification(name: String) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    @objc func getData(){
        fetchPlanList()
    }
    
    func removeNotification(name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(name), object: nil)
    }
    func updateIsComplete(index: Int) {
        worker.updateIsComplete(object: planList![index])
    }
    func addWillNotify(index: Int) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        //configuring notification content
        let content = UNMutableNotificationContent()
        content.title = (self.planList?[index].name)!
        content.body = "A long description of your notification"
        content.sound = UNNotificationSound.default

        content.userInfo = ["CustomData": (self.planList?[index].details)!]
        
        //specify the conditions for delivery
        
        //let yourDate = Calendar.current.date(byAdding: .second, value: 5, to: Date())!
        //let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: yourDate.timeIntervalSinceNow, repeats: false)
        
        let calender = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.calendar = calender
        dateComponents.weekday = calender.component(.weekday, from: (planList?[index].completionTime)!) // Tuesday
        dateComponents.hour = calender.component(.hour, from: (planList?[index].completionTime)!)
        dateComponents.minute = calender.component(.minute, from: (planList?[index].completionTime)!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        

        //create and register a notification request
    
        let request = UNNotificationRequest.init(identifier: String(index), content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
           if error != nil {
              print(error)
           }
        }
    }
    
    func updateWillNotify(index: Int) {
        worker.updateWillNotify(object: planList![index])
    }
    
    func removeWillNotify(identifier: [String]) {
    }
    func sendNotification(name: String) {
    }
    
    func alertAction(title: String, message: String, action: UIAlertAction) {
        presenter?.alertAction(title: title, message: message, action: action)
    }
    
    func alert(title: String, message: String) {
        presenter?.alert(title: title, message: message)
        
    }

}
