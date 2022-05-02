//
//  WorkoutTableViewCell.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 1.05.22.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    private let backgroundCell:UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "workoutImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull-Ups"
        label.font = UIFont.robotoMedium24()
        label.textColor = .specialBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.font = UIFont.robotoMedium14()
        label.textColor = .specialGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 10"
        label.font = UIFont.robotoMedium14()
        label.textColor = .specialGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.specialDarkGreen, for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
       
        addSubview(backgroundCell)
        addSubview(workoutView)
        addSubview(workoutImageView)
        addSubview(workoutTitleLabel)
        addSubview(workoutRepsLabel)
        addSubview(workoutSetsLabel)
        addSubview(startButton)
        
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            workoutView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            workoutView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            workoutView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            workoutImageView.centerXAnchor.constraint(equalTo: workoutView.centerXAnchor),
            workoutImageView.centerYAnchor.constraint(equalTo: workoutView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            workoutTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            workoutTitleLabel.leadingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: 10),
            workoutTitleLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            workoutRepsLabel.topAnchor.constraint(equalTo: workoutTitleLabel.bottomAnchor),
            workoutRepsLabel.leadingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: 10),
            workoutRepsLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            workoutSetsLabel.topAnchor.constraint(equalTo: workoutTitleLabel.bottomAnchor),
            workoutSetsLabel.leadingAnchor.constraint(equalTo: workoutRepsLabel.trailingAnchor),
            workoutSetsLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
        
}
