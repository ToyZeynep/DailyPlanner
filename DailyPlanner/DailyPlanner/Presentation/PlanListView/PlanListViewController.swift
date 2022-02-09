//
//  PlanListViewController.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import UIKit
import CoreData
import Foundation
import McPicker

protocol PlanListDisplayLogic: AnyObject {
    func displayPlan(viewModel: PlanList.Fetch.ViewModel)
}

final class PlanListViewController: UIViewController {
    var interactor: PlanListBusinessLogic?
    var router: (PlanListRoutingLogic & PlanListDataPassing)?
    var viewModel: PlanList.Fetch.ViewModel?
    
    
    @IBOutlet weak var planListAddButton: UIButton!
    @IBOutlet weak var planListImageView: UIImageView!
    @IBOutlet weak var planListDateLabel: UILabel!
    @IBOutlet weak var planListSearchBar: UISearchBar!
    @IBOutlet weak var planListFilterButton: UIButton!
    @IBOutlet weak var planListSortButton: UIButton!
    @IBOutlet weak var planListTableView: UITableView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planListTableView.registerNib(PlanListTableViewCell.self, bundle: .main)
        navigationController?.navigationBar.backgroundColor = .systemPurple
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PlanListInteractor(worker: PlanListWorker())
        let presenter = PlanListPresenter()
        let router = PlanListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
// MARK: ListDisplayLogic
extension PlanListViewController: PlanListDisplayLogic {
    func displayPlan(viewModel: PlanList.Fetch.ViewModel) {
        self.viewModel = viewModel
    }
}
 

// MARK: TableView Delegate and DataSource

extension PlanListViewController: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel?.planList.count == 0 {
                self.planListTableView.setEmptyMessage("Your PlanList is empty Let's start :)")
            } else {
                self.planListTableView.restore()
            }
        return (viewModel?.planList.count) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanListCell") as?
                PlanListTableViewCell else { return UITableViewCell() }

        isComplete(index: indexPath.row, button: cell.isCompleteButton)
        priorityViewStatus(index: indexPath.row, view: cell.priorityView)
        cell.isCompleteButton.addTapGesture { [self] in
            isCompleteButtonAction(index: indexPath.row)
        }
        willNotify(button: cell.willNotifyButton, index: indexPath.row)
        cell.willNotifyButton.addTapGesture { [self] in
            willNotifyChangeButtonAction(index: indexPath.row)
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func isComplete(index: Int , button: UIButton){
        switch viewModel?.planList[index]?.isComplete{
        case true:
            button.setImage(UIImage(named: "ok.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .systemPurple
        case false :
            button.setImage(UIImage(named: "x.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .systemPurple
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func isCompleteButtonAction(index: Int){
        
        let editAction = UIAlertAction(title: "OK", style: .default) { [self] UIAlertAction in
            
            interactor?.updateIsComplete(index: index)
            interactor?.fetchPlanList()
            planListTableView.reloadData()
        }
        switch viewModel?.planList[index]?.isComplete{
        case true:
        interactor?.alertAction(title: "Are You Sure ", message: "Do you want to mark as incomplete?", action: editAction)
        case false:
        interactor?.alertAction(title: "Are You Sure ", message: "Do you want to mark as complete?", action: editAction)
        case .none:
            break
        case .some(_):
            break
        }
    }
   
    func willNotify(button: UIButton , index: Int ){
        
        switch viewModel?.planList[index]?.willNotify {
        case true:
            interactor?.addWillNotify(index: index)
            button.setImage(UIImage(systemName: "bell.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        case false:
            button.setImage(UIImage(systemName: "bell.slash")?.withRenderingMode(.alwaysTemplate), for: .normal)
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func willNotifyChangeButtonAction(index: Int){
        
        let editAction = UIAlertAction(title: "OK", style: .default) { [self] UIAlertAction in
        interactor?.updateWillNotify(index: index)
        interactor?.fetchPlanList()
        planListTableView.reloadData()
    }
        switch viewModel?.planList[index]?.willNotify {
        case true:
            interactor?.alertAction(title: "Are You Sure ", message: "Don't want to receive notifications for this plan?", action: editAction)
        case false:
            interactor?.alertAction(title: "Are You Sure ", message: "Do you want to receive notifications for this plan?", action: editAction)
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func priorityViewStatus(index: Int , view: UIView){
        switch viewModel?.planList[index]?.priority{
            
        case Priority.high.rawValue:
            view.backgroundColor = .purple
        case Priority.medium.rawValue:
            view.backgroundColor = .systemPurple
        case Priority.low.rawValue:
            view.backgroundColor = .magenta
        case .none:
             break
        case .some(_):
            break
        }
    }
}
