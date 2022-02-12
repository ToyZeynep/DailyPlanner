//
//  SnackBar.swift
//  DailyPlanner
//
//  Created by MacOS on 11.02.2022.
//

import Foundation
import SnackBar_swift

class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .systemGray5
        style.textColor = .purple
        style.font = UIFont.boldSystemFont(ofSize: 16)
        style.actionTextColorAlpha = 0.6
        return style
    }
}




