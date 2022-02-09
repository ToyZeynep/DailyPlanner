//
//  PlanListRouter.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import UIKit

protocol PlanListRoutingLogic: AnyObject {
    func routeToDetails(index: Int)
    
}

protocol PlanListDataPassing: AnyObject {
    var dataStore: PlanListDataStore? { get }
}

final class PlanListRouter: PlanListRoutingLogic, PlanListDataPassing {
    
    weak var viewController: PlanListViewController?
    var dataStore: PlanListDataStore?

    func routeToDetails(index: Int) {
        let storyBoard = UIStoryboard(name: "PlanDetails", bundle: nil)
        let destVC: PlanDetailsViewController = storyBoard.instantiateViewController(identifier: "PlanDetails")
        let currentPlan = dataStore?.planList?[index]
        destVC.router?.dataStore?.plan = currentPlan!
        destVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destVC, animated: true)
    }
    
}

