//
//  UIView + Extensions.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 27.04.22.
//

import UIKit

extension UIView {
    
    func addShadowOnView() {
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 1.0
        
    }
}
