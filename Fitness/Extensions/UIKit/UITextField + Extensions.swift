//
//  UITextField + Extensions.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 26.05.22.
//

import UIKit

extension UITextField {
  
        convenience init(text: String = "") {
        self.init()

        self.backgroundColor = .specialBrown
        self.layer.cornerRadius = 10
        self.textColor = .specialGray
        self.font = .robotoBold20()
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftViewMode = .always
        self.clearButtonMode = .always
        self.returnKeyType = .done
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
    }
}
