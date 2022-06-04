//
//  ExercisesTableViewCell.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 19.05.22.
//

import UIKit

class ExercisesTableViewCell: UITableViewCell {
    
    private let workoutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.font = UIFont.robotoMedium24()
        label.textColor = .specialGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beforeLabel = UILabel(text: "Before: 357 min 56 sec")
    
    private let nowLabel = UILabel(text: "Now: 355 min 50 sec")
    
    private var labelsStackView = UIStackView()
    
    private let differenceLabel: UILabel = {
        let label = UILabel()
        label.text = "No data"
        label.textAlignment = .right
        label.font = UIFont.robotoMedium16()
        label.textColor = .specialGreen
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separateLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110428452, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
       
        addSubview(workoutTitleLabel)
        labelsStackView = UIStackView(arrangedSubviews: [beforeLabel, nowLabel], axis: .horizontal, spacing: 20)
        addSubview(labelsStackView)
        addSubview(differenceLabel)
        addSubview(separateLineView)
    }
    
    func cellConfigure(differenceWorkout: DifferenceWorkout){
        workoutTitleLabel.text = differenceWorkout.name
        
        var difference = 0
        
        if differenceWorkout.lastTimer == 0 {
            beforeLabel.text = "Before: \(differenceWorkout.firstReps)"
            nowLabel.text = "Now: \(differenceWorkout.lastReps)"
            difference = differenceWorkout.lastReps - differenceWorkout.firstReps
            differenceLabel.text = differenceWorkout.unique ? "na data" : "\(difference)"
        } else {
            difference = differenceWorkout.lastTimer - differenceWorkout.firstTimer
            let (minBefore, secBefore) = differenceWorkout.firstTimer.convertSeconds()
            let (minNow, secNow) = differenceWorkout.lastTimer.convertSeconds()
            let (minDif, secDif) = difference.convertSeconds()
            beforeLabel.text = "Before: \(minBefore) min \(secBefore) sec"
            nowLabel.text = "Now: \(minNow) min \(secNow) sec"
            if differenceWorkout.unique {
                differenceLabel.text = "na data"
            } else if minDif == 0 {
                differenceLabel.text = "\(secDif) sec"
            } else {
                differenceLabel.text = "\(minDif) min \(abs(secDif)) sec"
            }
        }
        
        switch difference{
        case ..<0: differenceLabel.textColor = .specialGreen
        case 1...: differenceLabel.textColor = .specialDarkYellow
        default:
            differenceLabel.textColor = .specialGray
        }
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            workoutTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            workoutTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])

        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: workoutTitleLabel.bottomAnchor, constant: 1),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
           // labelsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            separateLineView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 2),
            separateLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            separateLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            separateLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            differenceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            differenceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            differenceLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
}
