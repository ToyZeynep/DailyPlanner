//
//  ViewExtension.swift
//  DailyPlanner
//
//  Created by MacOS on 9.02.2022.
//

import Foundation
import UIKit
extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}


extension UIView {
    
    func addTapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}

extension UIView {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
}
extension UIView {
    func dropShadow() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.purple.cgColor
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    func dropViewShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.shadowColor = UIColor.purple.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(rgb: 0xe4bce5).cgColor,
                           UIColor.systemPurple.cgColor,
                           UIColor.white.cgColor]   // your colors go here
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

