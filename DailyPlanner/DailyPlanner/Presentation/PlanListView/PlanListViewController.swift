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
 
