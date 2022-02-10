//
//  PlanDetailsRouter.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import Foundation

protocol PlanDetailsRoutingLogic: AnyObject {
    func popOver()

}

protocol PlanDetailsDataPassing: AnyObject {
    var dataStore: PlanDetailsDataStore? { get }
}

final class PlanDetailsRouter: PlanDetailsRoutingLogic, PlanDetailsDataPassing {

    weak var viewController: PlanDetailsViewController?
    var dataStore: PlanDetailsDataStore?
    func popOver(){
    viewController?.navigationController?.popViewController(animated: true)
    }
}
