//
//  PlanListRouter.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import UIKit

protocol PlanListRoutingLogic: AnyObject {
    
}

protocol PlanListDataPassing: AnyObject {
    var dataStore: PlanListDataStore? { get }
}

final class PlanListRouter: PlanListRoutingLogic, PlanListDataPassing {
    
    weak var viewController: PlanListViewController?
    var dataStore: PlanListDataStore?
    
}

