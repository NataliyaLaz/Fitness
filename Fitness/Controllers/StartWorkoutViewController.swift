//
//  StartWorkoutViewController.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 15.05.22.
//

import Foundation
import UIKit

class StartWorkoutViewController:UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let startWorkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "START WORKOUT"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let sportsmenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sportsmen")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private var numberOfSet = 1
    
    private let exerciseView = ExerciseView()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("FINISH", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var workoutModel = WorkoutModel()
    let customAlert = CustomAlert()
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setWorkoutParameters()
        setDelegates()
        
        print(workoutModel)
    }
    
    private func setDelegates() {
        exerciseView.cellNextSetDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(startWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(sportsmenImageView)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(exerciseView)
        scrollView.addSubview(finishButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true, completion: nil)
            RealmManager.shared.updateWorkoutModel(model: workoutModel, bool: true)
        } else {
            alertOkCancel(title: "Warning", message: "You haven't finished your workout yet") {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func setWorkoutParameters() {
        exerciseView.exerciseNameLabel.text = workoutModel.workoutName
        exerciseView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        exerciseView.numberOfRepsLabel.text = "\(workoutModel.workoutReps)"
    }
}

//MARK: - NextSetProtocol

extension StartWorkoutViewController: NextSetProtocol{
   
    func editingTapped() {
        customAlert.alertCustom(viewController: self) { _, _ in
            print("1")
        }
    }
    
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            exerciseView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Hey", message: "You've finished your workout")
        }
    }
}

//MARK: - SetConstraints

extension StartWorkoutViewController {
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            sportsmenImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            sportsmenImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            sportsmenImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            sportsmenImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: sportsmenImageView.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            exerciseView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            exerciseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exerciseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exerciseView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: exerciseView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
}
