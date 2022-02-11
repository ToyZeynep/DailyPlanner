//
//  PlanListTableViewCell.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import UIKit
import Material

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
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = EdgeInsets(top: 8, left: 2, bottom: 2, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
          contentView.backgroundColor = UIColor.white
          contentView.layer.borderColor = UIColor.lightGray.cgColor
          contentView.layer.borderWidth = 0.5
          contentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
