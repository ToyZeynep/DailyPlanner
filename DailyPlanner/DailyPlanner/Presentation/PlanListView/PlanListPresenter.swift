//
//  PlanListPresenter.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//


import Foundation
import UIKit

protocol PlanListPresentationLogic: AnyObject {
    func presentPlan(response: PlanList.Fetch.Response)
    func alertAction(title: String , message: String , action: UIAlertAction)
    func alert(title: String , message: String)
}

final class PlanListPresenter: PlanListPresentationLogic {
    weak var viewController: PlanListDisplayLogic?
    func presentPlan(response: PlanList.Fetch.Response) {
        var planList: [PlanList.Fetch.ViewModel.Plan] = []
        response.planList.forEach {
            planList.append(PlanList.Fetch.ViewModel.Plan(name: $0.name,
                                                          completionTime: $0.completionTime,
                                                          isComplete: $0.isComplete,
                                                          details: $0.details,
                                                          priority: $0.priority,
                                                          willNotify: $0.willNotify,
                                                          category: $0.category ))
        }
        
        viewController?.displayPlan(viewModel: PlanList.Fetch.ViewModel(planList: planList))
    }
    
    func alertAction(title: String , message: String , action: UIAlertAction) {
        Alert.alertAction(title: title, message: message, action: action)
    }
    
    func alert(title: String , message: String){
        Alert.alert(title: title, message: message)
    }
}

