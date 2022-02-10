//
//  PlanDetailsViewController.swift
//  DailyPlanner
//
//  Created by MacOS on 10.02.2022.
//

import Foundation
import UIKit
import McPicker
import CoreData
import Material

protocol PlanDetailsDisplayLogic: AnyObject {
    func displayPlanDetails(viewModel: PlanDetails.Fetch.ViewModel)
    
}

class PlanDetailsViewController: UIViewController {
    
    var interactor: PlanDetailsBusinessLogic?
    var worker:  (CoreDataManagerProtocol & NotificationManagerProtocol)?
    var router: (PlanDetailsRoutingLogic & PlanDetailsDataPassing)?
   

    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PlanDetailsInteractor(worker: PlanDetailsWorker())
        let presenter = PlanDetailsPresenter()
        let router = PlanDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = UIColor(rgb: 0xc286d3)
        view.backgroundColor = UIColor(rgb: 0xc286d3)
    }
}

extension PlanDetailsViewController: PlanDetailsDisplayLogic {
    
    func displayPlanDetails(viewModel: PlanDetails.Fetch.ViewModel) {
        self.title = "AddPlan"
    }
}


