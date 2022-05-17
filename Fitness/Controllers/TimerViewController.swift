//
//  TimerViewController.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 17.05.22.
//

import UIKit

class TimerViewController: UIViewController {
    
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
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "circle")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "01:30"
        label.textColor = .specialGray
        label.font = .robotoBold45()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private var numberOfSet = 1
    
    private let exerciseTimerView = ExerciseTimerView()
    
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
        exerciseTimerView.cellNextSetTimerDelegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(startWorkoutLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(circleImageView)
        scrollView.addSubview(mainTimerLabel)
        scrollView.addSubview(detailsLabel)
        scrollView.addSubview(exerciseTimerView)
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
        exerciseTimerView.exerciseNameLabel.text = workoutModel.workoutName
        exerciseTimerView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return ((secs / 60), (secs % 60))
        }(workoutModel.workoutTimer)
        exerciseTimerView.timerLabel.text = "\(min) min \(sec) sec"
        mainTimerLabel.text = "\(min) : \(sec)"
    }
}

//MARK: - NextSetTimerProtocol

extension TimerViewController: NextSetTimerProtocol{
    
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            exerciseTimerView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Hey", message: "You've finished your workout")
        }
    }
}

//MARK: - SetConstraints

extension TimerViewController {
    
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
            circleImageView.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            circleImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            circleImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            circleImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            mainTimerLabel.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 20),
            mainTimerLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainTimerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            mainTimerLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            exerciseTimerView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 5),
            exerciseTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exerciseTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            exerciseTimerView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: exerciseTimerView.bottomAnchor, constant: 20),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            finishButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
}
