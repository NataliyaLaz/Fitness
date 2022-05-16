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
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull-Ups"
        label.font = UIFont.robotoMedium22()
        label.textColor = .specialBlack
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutRepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 10"
        label.font = UIFont.robotoMedium16()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutSetsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets: 10"
        label.font = UIFont.robotoMedium16()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.specialDarkGreen, for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var labelsStackView = UIStackView()
    
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
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsLabel, workoutSetsLabel], axis: .horizontal, spacing: 10)
        addSubview(labelsStackView)
        contentView.addSubview(startButton)//in order button to work
        
    }
    
        @objc private func startButtonTapped() {
            print("StartButtonTapped pressed")
//            let startWorkoutViewController = StartWorkoutViewController()
//            startWorkoutViewController.modalPresentationStyle = .fullScreen
//            present(startWorkoutViewController, animated: true, completion: nil)
        }
    
    func cellConfigure(model: WorkoutModel) {
        
        workoutTitleLabel.text = model.workoutName
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return ((secs / 60), (secs % 60))
        }(model.workoutTimer)
        
        workoutRepsLabel.text = (model.workoutTimer == 0) ? "Reps: \(model.workoutReps)" : "Timer : \(min) min \(sec) sec"
        workoutSetsLabel.text = "Sets: \(model.workoutSets)"
        
        guard let imageData = model.workoutImage else { return}
        guard let image = UIImage(data: imageData) else { return}
        
        workoutImageView.image = image
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            workoutView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutView.heightAnchor.constraint(equalToConstant: 70),
            workoutView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: workoutView.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutView.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            workoutTitleLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutTitleLabel.leadingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: 10),
            workoutTitleLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: workoutTitleLabel.bottomAnchor, constant: 0),
            labelsStackView.leadingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: 10),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
    
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: workoutView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
        
}
