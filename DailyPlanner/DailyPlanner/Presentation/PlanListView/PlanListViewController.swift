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
import Material

protocol PlanListDisplayLogic: AnyObject {
    func displayPlan(viewModel: PlanList.Fetch.ViewModel)
}

final class PlanListViewController: UIViewController {
    var interactor: (PlanListBusinessLogic & NotificationManagerListInteractorProtocol & LocalNotificationManagerProtocol)?
    var router: (PlanListRoutingLogic & PlanListDataPassing)?
    var viewModel: PlanList.Fetch.ViewModel?
    
    @IBOutlet weak var constantLabelYour: UILabel!
    @IBOutlet weak var constantLabelPlans: UILabel!
    @IBOutlet weak var percentIsCompleteLabel: UILabel!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var planListAddButton: UIButton!
    @IBOutlet weak var planListImageView: UIImageView!
    @IBOutlet weak var planListDateLabel: UILabel!
    @IBOutlet weak var planListSearchBar: UISearchBar!
    @IBOutlet weak var planListFilterButton: UIButton!
    @IBOutlet weak var planListSortButton: UIButton!
    @IBOutlet weak var planListTableView: UITableView!
    
    var completedPlan = 0 {
        didSet{
            percentIsCompleteLabel.text = "%\(completedPlan) completed"
        }
    }
    
    func percentIsComplete(){
       
        var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
        if viewModel?.planList.count != 0{
        for task in (self.viewModel?.planList)! {
            let str = task?.isComplete
            if str == true{
                filteredData.append(task)
            }
        }
            completedPlan = ((filteredData.count) * 100) / ((viewModel?.planList.count)!)
        }
        
    }
    
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
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        interactor?.fetchPlanList()
        planListTableView.registerNib(PlanListTableViewCell.self, bundle: .main)
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
    
    
    @IBAction func listAddButtonTapped(_ sender: Any) {
        router?.routeToAdd()
    }
    
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        showPicker(planListSortButton, list: sort )
    }
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        showPicker(planListFilterButton, list: filter)
    }
    
    let sort : [String] = [Sort.alfabetik1.rawValue , Sort.alfabetik2.rawValue , Sort.date1.rawValue , Sort.date2.rawValue , Filter.cancel.rawValue]
    
    let filter : [String] = [ Filter.categori.rawValue , Filter.isComplete.rawValue  ,Filter.priority.rawValue  , Filter.willNotify.rawValue ,Filter.cancel.rawValue ]

    var selectedSort : String?
    
    
    func showPicker(_ sender: UIButton, list: [String]){
        McPicker.showAsPopover(data:[list], fromViewController: self, sourceView: sender, doneHandler:{ [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self!.interactor?.fetchPlanList()
                switch name {
                
                case Filter.categori.rawValue :
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let categoriList = [Category.home.rawValue, Category.shopping.rawValue , Category.business.rawValue , Category.feelGood.rawValue]
                            self!.showPicker(sender, list: categoriList)
                        }
                case Filter.isComplete.rawValue:
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let isCompleteList = [IsComplete.completed.rawValue, IsComplete.inCompleted.rawValue]
                        self!.showPicker(sender, list: isCompleteList)
                    }
                        
                case Filter.priority.rawValue:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let priorityList = [Priority.high.rawValue, Priority.medium.rawValue, Priority.low.rawValue]
                        self!.showPicker(sender, list: priorityList)
                    }
                case Filter.willNotify.rawValue:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let notifyList = [WillNotify.willNotify.rawValue, WillNotify.willNotNotify.rawValue]
                        self!.showPicker(sender, list: notifyList)
                    }
                    
                    
                case Category.home.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.category
                        if str!.contains("home"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Category.business.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.category
                        if str!.contains("business"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Category.shopping.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.category
                        if str!.contains("shopping"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Category.feelGood.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.category
                        if str!.contains("feelGood"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Priority.high.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.priority
                        if str!.contains("high"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Priority.medium.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.priority
                        if str!.contains("medium"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Priority.low.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.priority
                        if str!.contains("low"){
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case IsComplete.completed.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        
                        if task?.isComplete == true{
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case IsComplete.inCompleted.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.isComplete
                        if str == false{
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case WillNotify.willNotify.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.willNotify
                        if str == true{
                            filteredData.append(task)
                        }
                    }
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case WillNotify.willNotNotify.rawValue:
                    
                    self!.interactor?.fetchPlanList()
                    var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
                    for task in (self!.viewModel?.planList)! {
                        let str = task?.willNotify
                        if str == false{
                            filteredData.append(task)
                        }
                    }
                
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: filteredData)
                    self!.planListTableView.reloadData()
                    
                case Sort.alfabetik1.rawValue:
                    
                    let sortList =  self!.viewModel?.planList.sorted(by:{ ($0?.name!)! < ($1?.name!)!})
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: sortList!)
                    self!.planListTableView.reloadData()
                    
                case Sort.alfabetik2.rawValue:
                    
                    let sortList =  self!.viewModel?.planList.sorted(by:{ ($0?.name!)! > ($1?.name!)!})
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: sortList!)
                    self!.planListTableView.reloadData()
                    
                case Sort.date1.rawValue:
                    
                    let sortList =  self!.viewModel?.planList.sorted(by:{ ($0?.completionTime!)! < ($1?.completionTime!)!})
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: sortList!)
                    self!.planListTableView.reloadData()
                    
                case Sort.date2.rawValue:
                    
                    let sortList =  self!.viewModel?.planList.sorted(by:{ ($0?.completionTime!)! > ($1?.completionTime!)!})
                    self!.viewModel?.planList.removeAll()
                    self!.viewModel?.planList.append(contentsOf: sortList!)
                    self!.planListTableView.reloadData()

                        
                case Filter.cancel.rawValue :
                    
                    self!.interactor?.fetchPlanList()
                    self!.planListTableView.reloadData()
                    
                default:
                    break
           }
        }
     }
  )}
    
  
    
}

// MARK: ListDisplayLogic
extension PlanListViewController: PlanListDisplayLogic {
    func displayPlan(viewModel: PlanList.Fetch.ViewModel) {
        self.viewModel = viewModel
        planListTableView.reloadData()
        planListFilterButton.setImage(UIImage(named: "filter.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        planListFilterButton.tintColor = UIColor(rgb: 0x9969c1)
        planListSortButton.setImage(UIImage(named: "sort.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        planListSortButton.tintColor = UIColor(rgb: 0x9969c1)
        planListAddButton.layer.cornerRadius = 30
        planListAddButton.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        planListAddButton.tintColor = .white
        planListAddButton.backgroundColor = .systemPurple
        planListSearchBar.borderColor = UIColor(rgb: 0xe4bce5)
        planListSearchBar.tintColor = UIColor(rgb: 0xe4bce5)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        let date = formatter.string(from: Date())
        planListDateLabel.text =  date
        percentIsComplete()
        
        
    }
}
 

// MARK: TableView Delegate and DataSource

extension PlanListViewController: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel?.planList.count == 0 {
                self.planListTableView.setEmptyMessage("Your PlanList is empty ! Let's start :)")
            } else {
                self.planListTableView.restore()
            }
        return (viewModel?.planList.count) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanListTableViewCell") as?
                PlanListTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = viewModel?.planList[indexPath.row]?.name
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        let date = formatter.string(from: (viewModel?.planList[indexPath.row]?.completionTime)!)
        cell.dateLabel.text = date
        categoryImageView(index: indexPath.row, imageView: cell.categoryImageView)
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
        router?.routeToDetails(index: indexPath.row)
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        viewModel?.planList.remove(at: indexPath.row)
        self.planListTableView.deleteRows(at: [indexPath], with: .automatic)
        interactor?.removePlan(index: indexPath.row)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func isComplete(index: Int , button: UIButton){
       
        
        switch viewModel?.planList[index]?.isComplete{
        case true:
            button.setImage(UIImage(named: "ok.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor =  UIColor(rgb: 0x9969c1)
           
        case false :
            button.setImage(UIImage(named: "x.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = UIColor(rgb: 0xe4bce5)
        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func isCompleteButtonAction(index: Int){
        percentIsComplete()
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
        button.tintColor = UIColor(rgb: 0xe4bce5)
        switch viewModel?.planList[index]?.willNotify {
        case true:
            button.tintColor = UIColor(rgb: 0x9969c1)
            interactor?.addWillNotify(index: index)
            button.setImage(UIImage(systemName: "bell.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        case false:
            button.tintColor = UIColor(rgb: 0xe4bce5)
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
            view.backgroundColor = .magenta
        case Priority.low.rawValue:
            view.backgroundColor = UIColor(rgb: 0xe4bce5)
        case .none:
             break
        case .some(_):
            break
        }
    }
    
    func categoryImageView(index: Int , imageView: UIImageView){
        imageView.tintColor = UIColor(rgb: 0xe4bce5)
        switch viewModel?.planList[index]?.category{
            
        case Category.home.rawValue:
            imageView.image = UIImage(systemName: "homekit")
        case Category.business.rawValue:
            imageView.image =  UIImage(systemName: "bag")
        case Category.feelGood.rawValue:
            imageView.image =  UIImage(systemName: "star.fill")
        case Category.shopping.rawValue:
            imageView.image =  UIImage(systemName: "cart.badge.plus.fill")
        case .none:
            break
        case .some(_):
            break
        }
        
    }
}
//MARK: SearchBar Delegate

extension PlanListViewController : UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(PlanListViewController.reload), object: nil)
        self.perform(#selector(PlanListViewController.reload), with: nil, afterDelay: 0.7)
      }
    
    @objc func reload() {
        guard let searchText = planListSearchBar.text else { return }
        if searchText == "" {
            
            self.viewModel?.planList.removeAll()
            interactor?.fetchPlanList()
            planListTableView.reloadData()
        } else {
            search(searchText: searchText)
        }
    }

    func search(searchText: String){
        var filteredData = [PlanList.Fetch.ViewModel.Plan?]()
        for task in (viewModel?.planList)! {
            let str = task?.name
            if str!.contains(searchText){
                filteredData.append(task)
            }
        }
        viewModel?.planList.removeAll()
        viewModel?.planList.append(contentsOf: filteredData)
        planListTableView.reloadData()
    }
}
