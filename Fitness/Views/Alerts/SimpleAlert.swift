//
//  SimpleAlert.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 9.05.22.
//

import UIKit

extension UIViewController {
    
    func alertOK(title: String, message: String?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(ok)
        
        present(alertController, animated: true, completion: nil)
    }
}

