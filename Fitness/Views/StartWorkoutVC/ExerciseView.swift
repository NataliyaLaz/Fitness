//
//  ExerciseView.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 15.05.22.
//

import Foundation
import UIKit

class ExerciseView: UIView {
    
    private let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let setsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "1/4"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps"
        label.font = .robotoMedium18()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var setsStackView = UIStackView()
    
    private let separateLabel1: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110428452, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var repsStackView = UIStackView()
    
    private let separateLabel2: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110428452, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.font = .robotoMedium18()
        button.tintColor = #colorLiteral(red: 0.7254901961, green: 0.7058823529, blue: 0.6392156863, alpha: 1)
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 15, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 50, left: -40, bottom: 0, right: 0)
        button.setImage(UIImage(named: "editing"), for: .normal)
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(exerciseNameLabel)
        
        setsStackView = UIStackView(arrangedSubviews: [setsLabel, numberOfSetsLabel], axis: .horizontal, spacing: 10)
        
        addSubview(setsStackView)
        addSubview(separateLabel1)
        
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, numberOfRepsLabel], axis: .horizontal, spacing: 10)
        
        addSubview(repsStackView)
        addSubview(separateLabel2)
        addSubview(editingButton)

    }
    
    @objc private func editingButtonTapped() {
       print("Editing button pressed")
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            exerciseNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            exerciseNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor, constant: 20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            separateLabel1.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 3),
            separateLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            separateLabel1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            separateLabel1.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            separateLabel2.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 3),
            separateLabel2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            separateLabel2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            separateLabel2.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: separateLabel2.bottomAnchor, constant: 15),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            editingButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
