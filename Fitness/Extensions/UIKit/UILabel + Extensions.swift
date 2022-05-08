//
//  UILabel + Extensions.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 8.05.22.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "") {
        self.init()
        
        self.text = text
        self.font = .robotoMedium14()
        self.textColor = .specialLightBrown
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
