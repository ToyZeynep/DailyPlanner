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
    var category: String?
    var willNotify : Bool?
    var isComplete: Bool?
    var priority : String?
    
    
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
        
        if sender.selectedSegmentIndex == 0 {
            category = Category.home.rawValue
            print("home")
        }else  if sender.selectedSegmentIndex == 1 {
            print("business")
            category =  Category.business.rawValue
        }else  if sender.selectedSegmentIndex == 2 {
            print("shopping")
            category =  Category.shopping.rawValue
        }else if sender.selectedSegmentIndex == 3 {
            print("feelGood")
            category =  Category.feelGood.rawValue
        }
    }
    
    @IBAction func DetailsPriortySegmentAction(_ sender: UISegmentedControl) {
       
        if sender.selectedSegmentIndex == 0 {
           
            priority = Priority.high.rawValue
            print("low")
        }else  if sender.selectedSegmentIndex == 1 {
            priority = Priority.medium.rawValue
            print("medium")
        }else  if sender.selectedSegmentIndex == 2 {
            priority = Priority.low.rawValue
            print("high")
        }else {
            
        }
    }
    
    @IBAction func detailsNotifMeSwitchAction(_ sender: UISwitch) {
        if (sender.isOn == true )
        {
            willNotify = true
        }else{
            willNotify = false
        }
    }
    
    @IBAction func DetailsAddButtonTapped(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        let date = formatter.string(from: detailsDatePicker.date)
        let completionTime: Date = detailsDatePicker.date
        if completionTime < Date() {
            interactor?.alert(title: "Please enter a completion date that is in the future.", message: "Invalid Date")
            return
        }
        guard let planName = detailsNameTextField.text,
              !planName.isEmpty else {
                  interactor?.alert(title: "Please enter a task name", message: "Invalid Task Name")
                  return
        }
        interactor?.AddPlanDetails(completionTime: completionTime, name: planName, details: detailsTextField.text ?? "", isComplete: false , priority: self.priority ?? "low" , willNotify: self.willNotify ?? false , category: self.category ?? "home")
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.router?.popOver()
            self.interactor?.sendNotification(name: "AddPlan")
        }
        interactor?.alertAction(title: "Congratulations", message: "Added Plan", action: alertAction)
    }
}

extension PlanDetailsViewController: PlanDetailsDisplayLogic {
    
    func displayPlanDetails(viewModel: PlanDetails.Fetch.ViewModel) {
        self.title = "AddPlan"
        detailsAddView.layer.cornerRadius = 10
        detailsAddView.layer.shadowOffset = CGSize(width: 20, height: 20)
        detailsAddView.layer.shadowColor = UIColor.purple.cgColor
        detailsAddView.layer.shadowRadius = 6
        detailsAddView.layer.shadowOpacity = 1
        detailsAddView.layer.shouldRasterize = true
        detailsAddView.layer.rasterizationScale = UIScreen.main.scale
        detailsAddButton.layer.cornerRadius = 22.5
        detailsAddButton.backgroundColor = .systemPurple
        detailsAddButton.setImage(UIImage(named: "ok.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        detailsAddButton.tintColor = .white
    }
}


