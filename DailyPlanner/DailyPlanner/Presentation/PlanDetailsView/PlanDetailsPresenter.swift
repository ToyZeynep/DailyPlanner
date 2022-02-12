//
//  PlanDetailsPresenter.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import Foundation
import UIKit

protocol PlanDetailsPresentationLogic: AnyObject {
    func presentPlanDetails(response: PlanDetails.Fetch.Response)
    func alertAction(title: String , message: String,  action: UIAlertAction)
    func alert(title: String , message: String)
}

final class PlanDetailsPresenter: PlanDetailsPresentationLogic {
    weak var viewController: PlanDetailsDisplayLogic?
    
    func presentPlanDetails(response: PlanDetails.Fetch.Response) {
        let currentDate = Date()
        viewController?.displayPlanDetails(viewModel: PlanDetails.Fetch.ViewModel(
            name: response.plan?.name ?? "" ,
            completionTime: response.plan?.completionTime ?? currentDate,
            isComplete: response.plan?.isComplete ?? false,
            details: response.plan?.details ??  "",
            priority: response.plan?.priority ?? "",
            willNotify: response.plan?.willNotify ?? true,
            category: response.plan?.category ?? "home"
        )
        )
    }
    
    func alertAction(title: String , message: String , action: UIAlertAction) {
        Alert.alertAction(title: title, message: message, action: action)
    }
    
    func alert(title: String , message: String){
        Alert.alert(title: title, message: message)
    }
}

