//
//  ViewController.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import UIKit
import SwiftGifOrigin

class SplashViewController: UIViewController {
    
    @IBOutlet weak var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splashImageView.loadGif(asset: "splash")
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        splashImageView.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor(rgb: 0xe4bce5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            let storyBoard = UIStoryboard(name: "PlanList", bundle: nil)
            let destVC: PlanListViewController = storyBoard.instantiateViewController(identifier: "PlanList")
            destVC.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(destVC, animated: true)
            
        }
    }
}
