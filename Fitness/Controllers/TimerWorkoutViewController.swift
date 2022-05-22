//
//  TimerViewController.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 17.05.22.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
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
        label.font = .robotoBold48()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel = UILabel(text: "Details")
    
    private var numberOfSet = 0
    
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
    
    let customAlert = CustomAlert()
    
    let shapeLayer = CAShapeLayer()// Core Animation in order to work with animation
    
    var timer = Timer()
    var durationTimer = 10
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setWorkoutParameters()
        setDelegates()
        addTaps()
        
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
        timer.invalidate()
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true, completion: nil)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        } else {
            alertOkCancel(title: "Warning", message: "You haven't finished your workout yet") {
                self.dismiss(animated: true)
            }
        }
        timer.invalidate()
    }
    
    private func setWorkoutParameters() {
        exerciseTimerView.exerciseNameLabel.text = workoutModel.workoutName
        exerciseTimerView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        let (min, sec) = workoutModel.workoutTimer.convertSeconds()
        exerciseTimerView.timerLabel.text = "\(min) min \(sec) sec"
        mainTimerLabel.text = "\(min) : \(sec.setZeroForSeconds())"
        durationTimer = workoutModel.workoutTimer
    }
    
    private func addTaps() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        mainTimerLabel.isUserInteractionEnabled = true
        mainTimerLabel.addGestureRecognizer(tapLabel)
    }
    
    @objc private func startTimer() {

        exerciseTimerView.editingButton.isEnabled = false
        exerciseTimerView.nextSetButton.isEnabled = false
        mainTimerLabel.isUserInteractionEnabled = false
        
        if numberOfSet ==  workoutModel.workoutSets {
            alertOK(title: "Hey", message: "You've finished your workout")
            
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil, repeats: true)// every 1 second timerAction will repeat
        }
    }
    
    @objc private func timerAction() {
        
            durationTimer -= 1
            print(durationTimer)
            
            if durationTimer == 0 {
                timer.invalidate()
                durationTimer = workoutModel.workoutTimer
                
                numberOfSet += 1
                exerciseTimerView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
                
                exerciseTimerView.editingButton.isEnabled = true
                exerciseTimerView.nextSetButton.isEnabled = true
                mainTimerLabel.isUserInteractionEnabled = true
            }
            
            let (min, sec) = durationTimer.convertSeconds()
            mainTimerLabel.text = "\(min) : \(sec.setZeroForSeconds())"
    }
}

//MARK: - Animation

extension TimerWorkoutViewController{
    
    private func animationCircular(){
        
        let center = CGPoint(x: circleImageView.frame.width / 2, y: circleImageView.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 135, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1//it will go to our end point
        shapeLayer.lineCap = .round // round end of line
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        circleImageView.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0//full circle
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}


//MARK: - NextSetTimerProtocol

extension TimerWorkoutViewController: NextSetTimerProtocol{
    
    func editingTimerTapped() {
        customAlert.alertCustom(viewController: self, repsOrTimer: "Timer of Set") { sets, timerOfSet in//?[self] before sets, reps
            if sets != "" && timerOfSet != "" {
                guard let numberOfSets = Int(sets) else { return }
                guard let numberOfTimer = Int(timerOfSet) else { return }
                let (min, sec) = numberOfTimer.convertSeconds()
                self.exerciseTimerView.numberOfSetsLabel.text = "\(self.numberOfSet)/\(numberOfSets)"
                self.exerciseTimerView.timerLabel.text = "\(min) min \(sec) sec"
                self.mainTimerLabel.text = "\(min):\(sec.setZeroForSeconds())"
                self.durationTimer = numberOfTimer
                RealmManager.shared.updateSetsTimerWorkoutModel(model: self.workoutModel, sets: numberOfSets, timer: numberOfTimer)
            }
        }
    }
    
    func nextSetTimerTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            exerciseTimerView.numberOfSetsLabel.text = "\(numberOfSet)/\(workoutModel.workoutSets)"
        } else {
            alertOK(title: "Hey", message: "You've finished your workout")
        }
    }
}

//MARK: - SetConstraints

extension TimerWorkoutViewController {
    
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
            mainTimerLabel.leadingAnchor.constraint(equalTo: circleImageView.leadingAnchor, constant: 40),
            mainTimerLabel.trailingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: -40),
            mainTimerLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor),
          
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
