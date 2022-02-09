//
//  PlanListTableViewCell.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import UIKit

class PlanListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var willNotifyButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
