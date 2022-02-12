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
    
    //Add view
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
    
    //Details view
    @IBOutlet weak var calendarDayLabel: UILabel!
    @IBOutlet weak var calendarMounthLabel: UILabel!
    @IBOutlet weak var CalendarView: UIView!
    @IBOutlet weak var detailsDetailsView: UIView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsDetailsLabel: UILabel!
    @IBOutlet weak var calendarWeekDayLabel: UILabel!
    
    @IBOutlet weak var detailsViewCategoryLabel: UILabel!
    @IBOutlet weak var detailsViewCategoryImageView: UIImageView!
    @IBOutlet weak var detailsViewPriorityStatusLabel: UILabel!
    @IBOutlet weak var detailsViewPriorityLabel: UILabel!
    @IBOutlet weak var detailsViewWillNotifyImageView: UIImageView!
    @IBOutlet weak var detailsViewWillNotifyLabel: UILabel!
    @IBOutlet weak var detailsViewIsCompleteImageView: UIImageView!
    @IBOutlet weak var detailsIsCompleteLabel: UILabel!
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
        self.hideKeyboardWhenTappedAround()
        interactor?.fetchPlanDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .clear
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
           
            priority = Priority.low.rawValue
            
        }else  if sender.selectedSegmentIndex == 1 {
            priority = Priority.medium.rawValue
           
        }else  if sender.selectedSegmentIndex == 2 {
            priority = Priority.high.rawValue
            
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
            detailsAddView.shake()
            interactor?.alert(title: "Please enter a completion date that is in the future.", message: "Invalid Date")
            return
        }
        guard let planName = detailsNameTextField.text,
              !planName.isEmpty else {
                  detailsAddView.shake()
                  interactor?.alert(title: "Please enter a task name", message: "Invalid Task Name")
                  return
        }
        interactor?.AddPlanDetails(completionTime: completionTime, name: planName, details: detailsTextField.text ?? "", isComplete: false , priority: self.priority ?? "low" , willNotify: self.willNotify ?? true , category: self.category ?? "home")
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.router?.popOver()
            self.interactor?.sendNotification(name: "AddPlan")
        }
        interactor?.alertAction(title: "Congratulations", message: "Added Plan", action: alertAction)
    }
}

extension PlanDetailsViewController: PlanDetailsDisplayLogic {
    
    func displayPlanDetails(viewModel: PlanDetails.Fetch.ViewModel) {
        
        
        if router?.dataStore?.plan?.name != nil{
            self.title = "Details"
            detailsAddView.isUserInteractionEnabled = false
            detailsAddView.isHidden = true
            detailsDetailsView.backgroundColor = .white
            detailsDetailsView.dropViewShadow()
            detailsNameLabel.text = viewModel.name
            detailsDetailsLabel.text = viewModel.details
            let date = viewModel.completionTime
            calendarWeekDayLabel.text = date?.dayInWeek
            calendarDayLabel.text = date?.day
            calendarMounthLabel.text = date?.month
            categoryImageViewStatus()
            CalendarView.dropShadow()
            isCompleteStatus()
            willNotifyStatus()
            priorityStatus()
        } else {
        
            detailsDetailsView.isHidden = true
            detailsDetailsView.isUserInteractionEnabled = false
            self.title = "AddPlan"
            detailsAddView.dropViewShadow()
            self.detailsAddButton.layer.cornerRadius = 25
            self.detailsAddButton.backgroundColor = .systemPurple
            self.detailsAddButton.setImage(UIImage(named: "ok.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.detailsAddButton.tintColor = .white
 }
        
        func categoryImageViewStatus(){
            switch viewModel.category {
               
                case Category.home.rawValue:
                detailsViewCategoryImageView.image = UIImage(systemName: "homekit")
                case Category.business.rawValue:
                detailsViewCategoryImageView.image =  UIImage(systemName: "bag")
                case Category.feelGood.rawValue:
                detailsViewCategoryImageView.image =  UIImage(systemName: "star.fill")
                case Category.shopping.rawValue:
                detailsViewCategoryImageView.image =  UIImage(systemName: "cart.badge.plus.fill")
                case .none:
                    break
                case .some(_):
                    break
        }
    }
        
        func isCompleteStatus(){
            switch viewModel.isComplete {
            case true:
                detailsViewIsCompleteImageView.image = UIImage(named: "ok.png")!.withRenderingMode(.alwaysTemplate)
            case false:
                detailsViewIsCompleteImageView.image = UIImage(named: "x.png")!.withRenderingMode(.alwaysTemplate)
            case .none:
                break
            case .some(_):
                break
            }
        }
        
        func willNotifyStatus(){
            switch viewModel.willNotify {
            case true:
                detailsViewWillNotifyImageView.image = UIImage(systemName: "bell.fill")
                detailsViewWillNotifyImageView.tintColor = UIColor(rgb: 0xe4bce5)
            case false:
                detailsViewWillNotifyImageView.image = UIImage(systemName: "bell.slash")
                detailsViewWillNotifyImageView.tintColor = UIColor(rgb: 0xe4bce5)
            case .none:
                break
            case .some(_):
                break
            }
        }
        
        
        func priorityStatus(){
            switch viewModel.priority {
             
                    
                case Priority.high.rawValue:
                detailsViewPriorityStatusLabel.text = "high"
                case Priority.medium.rawValue:
                detailsViewPriorityStatusLabel.text = "medium"
                case Priority.low.rawValue:
                detailsViewPriorityStatusLabel.text = "low"
                case .none:
                    break
                case .some(_):
                    break
            }
}
}
}
