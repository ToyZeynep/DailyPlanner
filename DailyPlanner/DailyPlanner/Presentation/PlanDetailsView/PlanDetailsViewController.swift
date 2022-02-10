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
    
    var interactor: (PlanDetailsBusinessLogic & NotificationManagerPlanDetailsProtocol)?
    var worker:  (CoreDataManagerProtocol & NotificationManagerProtocol)?
    var router: (PlanDetailsRoutingLogic & PlanDetailsDataPassing)?
    
    @IBOutlet weak var detailsCategoryLabel: UILabel!
    @IBOutlet weak var detailsCategorySegment: UISegmentedControl!
    @IBOutlet weak var detailsPriortyLabel: UILabel!
    @IBOutlet weak var detailsPrioritySegment: UISegmentedControl!
    @IBOutlet weak var detailsAddButton: UIButton!
    @IBOutlet weak var detailsAddView: UIView!
    @IBOutlet weak var detailsNameTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var detailsDatePicker: UIDatePicker!
    @IBOutlet weak var detailsNotifMeLabel: UILabel!
    @IBOutlet weak var detailsNotifMeSwitch: UISwitch!
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
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
    
    @IBAction func detailsCategorySegmentAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func DetailsPriortySegmentAction(_ sender: UISegmentedControl) {
       
    }
    
    @IBAction func detailsNotifMeSwitchAction(_ sender: UISwitch) {
        
    }
    
    @IBAction func DetailsAddButtonTapped(_ sender: Any) {
        
    }

   
    
   
}

extension PlanDetailsViewController: PlanDetailsDisplayLogic {
    
    func displayPlanDetails(viewModel: PlanDetails.Fetch.ViewModel) {
        self.title = "AddPlan"
    }
}


