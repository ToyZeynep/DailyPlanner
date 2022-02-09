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
        splashImageView.tintColor = .systemPurple
        splashImageView.loadGif(asset: "splash")
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        
    }

}

