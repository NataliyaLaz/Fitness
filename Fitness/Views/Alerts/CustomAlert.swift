//
//  CustomAlert.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 18.05.22.
//

import UIKit

class CustomAlert {
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0//without TAMIK because we will use frames here in CustomAlert
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var mainView: UIView?
    
    func alertCustom(viewController: UIViewController, completion: @escaping (String, String) -> Void) {// @escaping отрабатывает после вызова
        
        guard let parentView = viewController.view else { return }
        mainView = parentView
        
        backgroundView.frame = parentView.frame
        parentView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -420,
                                 width: parentView.frame.width - 80,
                                 height: 420)
        parentView.addSubview(alertView)
        
        let sportsmanImageView = UIImageView(frame: CGRect(x: (alertView.frame.width - alertView.frame.height * 0.4) / 2,
                                                           y: 30,
                                                           width: alertView.frame.height * 0.4,
                                                           height: alertView.frame.height * 0.4))
        sportsmanImageView.image = UIImage(named: "sportsmanAlert")
        sportsmanImageView.contentMode = .scaleAspectFit
        alertView.addSubview(sportsmanImageView)
        
        let editingLabel = UILabel(frame: CGRect(x: 10,
                                                 y: alertView.frame.height * 0.4 + 50,
                                                 width: alertView.frame.width - 20,
                                                 height: 25))
        editingLabel.text = "Editing"
        editingLabel.textAlignment = .center
        editingLabel.font = .robotoMedium22()
        editingLabel.textColor = .specialDarkGreen
        alertView.addSubview(editingLabel)
        
        let setsLabel = UILabel(text: "Sets")
        setsLabel.translatesAutoresizingMaskIntoConstraints = true
        setsLabel.frame = CGRect(x: 30,
                                 y: editingLabel.frame.maxY + 10,//lowest point of editingLabel + 10
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(setsLabel)
        
        let setsTextField = UITextField(frame: CGRect(x: 20,
                                                      y: setsLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30))
        setsTextField.backgroundColor = .specialBrown
        setsTextField.layer.cornerRadius = 10
        setsTextField.textColor = .specialGray
        setsTextField.font = .robotoBold20()
        setsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: setsTextField.frame.height))
        setsTextField.leftViewMode = .always
        setsTextField.clearButtonMode = .always
        setsTextField.returnKeyType = .done
        setsTextField.keyboardType = .numberPad
        alertView.addSubview(setsTextField)
        
        let repsLabel = UILabel(text: "Reps")
        repsLabel.translatesAutoresizingMaskIntoConstraints = true
        repsLabel.frame = CGRect(x: 30,
                                 y: setsTextField.frame.maxY + 3,
                                 width: alertView.frame.width - 60,
                                 height: 20)
        alertView.addSubview(repsLabel)
        
        let repsTextField = UITextField(frame: CGRect(x: 20,
                                                      y: repsLabel.frame.maxY,
                                                      width: alertView.frame.width - 40,
                                                      height: 30))
        repsTextField.backgroundColor = .specialBrown
        repsTextField.layer.cornerRadius = 10
        repsTextField.textColor = .specialGray
        repsTextField.font = .robotoBold20()
        repsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: repsTextField.frame.height))
        repsTextField.leftViewMode = .always
        repsTextField.clearButtonMode = .always
        repsTextField.returnKeyType = .done
        repsTextField.keyboardType = .numberPad
        alertView.addSubview(repsTextField)
        
        let okButton = UIButton(frame: CGRect(x: 50,
                                              y: repsTextField.frame.maxY + 15,
                                              width: alertView.frame.width - 100,
                                              height: 35))
        okButton.backgroundColor = .specialGreen
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.textColor = .white
        okButton.titleLabel?.font = .robotoMedium18()
        okButton.layer.cornerRadius = 10
        okButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(okButton)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.6
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.3) {
                    self.alertView.center = parentView.center
                }
            }
        }
    }
    
    @objc private func dismissAlert() {
        print("OK pressed")
    }
}
