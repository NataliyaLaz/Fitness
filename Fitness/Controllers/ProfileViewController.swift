//
//  ProfileViewController.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 8.05.22.
//

import UIKit
import RealmSwift

struct ResultWorkout {
    let name: String
    let result: Int
    let imageData: Data?
}

class ProfileViewController: UIViewController {
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true//обрезка краев
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "USER NAME"
        label.textColor = .white
        label.font = .robotoBold24()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height: _"
        label.textColor = .specialGray
        label.font = .robotoBold16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight: _"
        label.textColor = .specialGray
        label.font = .robotoBold16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var HeightAndWeightStackView = UIStackView()
    
    private lazy var editingButton: UIButton = {
        
        var configuration = UIButton.Configuration.borderless()
        configuration.baseForegroundColor = .specialGreen
        configuration.baseBackgroundColor = .clear
        configuration.buttonSize = .large
        configuration.title = "Editing "
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0)
        configuration.imagePadding = 0
        configuration.attributedTitle?.font = .robotoMedium16()
        configuration.image = UIImage(named: "profileEditing")
        configuration.imagePlacement = .trailing
        configuration.titleAlignment = .trailing

        let button = UIButton(configuration: configuration, primaryAction: nil)
        
        button.addTarget(self, action: #selector(editingProfileButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let targetLabel: UILabel = {
        let label = UILabel()
        label.text = "TARGET: _ workouts"
        label.textColor = .specialGray
        label.font = .robotoBold16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetStartLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetEndLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .specialGray
        label.font = .robotoBold24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let targetUpperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .specialGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .specialBrown
        progressView.progressTintColor = .specialGreen
        progressView.layer.cornerRadius = 14
        progressView.clipsToBounds = true
        progressView.setProgress(0, animated: true)
        progressView.layer.sublayers?[1].cornerRadius = 14
        progressView.subviews[1].clipsToBounds = true
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    
    private var targetStackView = UIStackView()
    
    private let idProfileCell = "idProfileCell"
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    
    private var resultWorkout: [ResultWorkout] = []
    
    override func viewWillAppear(_ animated: Bool) {
        setupUserParameters()
    }
  
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userArray = localRealm.objects(UserModel.self)
        
        setupViews()
        setConstraints()
        setDelegates()
        getWorkoutResults()
       
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: idProfileCell)
    }
    
    deinit {
        print ("ProfileViewController was deinited")
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(profileLabel)
        view.addSubview(profileView)
        view.addSubview(userPhotoImageView)
        view.addSubview(nameLabel)
        HeightAndWeightStackView = UIStackView(arrangedSubviews: [heightLabel,weightLabel], axis: .horizontal, spacing: 10)
        view.addSubview(HeightAndWeightStackView)
        view.addSubview(editingButton)
        view.addSubview(collectionView)
        view.addSubview(targetLabel)
        targetStackView = UIStackView(arrangedSubviews: [targetStartLabel, targetEndLabel],
                                         axis: .horizontal,
                                         spacing: 10)
        view.addSubview(targetStackView)
        view.addSubview(targetView)
        view.addSubview(targetUpperView)
        view.addSubview(progressView)
    }
    
    @objc private func editingProfileButtonTapped() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        present(settingsViewController, animated: true, completion: nil)
    }
    
    private func setDelegates() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func getWorkoutsName() -> [String] {
        
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)//get data from realm
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName){
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getWorkoutResults() {
     
        let nameArray = getWorkoutsName()
        
        for name in nameArray{
            let predicateName = NSPredicate(format: "workoutName = '\(name)'")
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateName)
            var result = 0
            var image: Data?
            workoutArray.forEach { model in
                result += model.workoutReps
                image = model.workoutImage
            }
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            resultWorkout.append(resultModel)
        }
    }
    
    func setupUserParameters() {
        if userArray.count != 0 {
            nameLabel.text = userArray[0].firstName + " " + userArray[0].secondName
            heightLabel.text = "Height: \(userArray[0].height)"
            weightLabel.text = "Weight: \(userArray[0].weight)"
            targetLabel.text = "TARGET: \(userArray[0].target) workouts"
            targetEndLabel.text = "\(userArray[0].target)"
            
            guard let data = userArray[0].image else { return }
            guard let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
        }
    }
}

//MARK: - SetConstraints

extension ProfileViewController {
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            HeightAndWeightStackView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 5),
            HeightAndWeightStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            HeightAndWeightStackView.heightAnchor.constraint(equalToConstant: 25)
            
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 5),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            editingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            editingButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: HeightAndWeightStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 270)
        ])
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            targetStackView.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 10),
            targetStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            targetStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            targetView.topAnchor.constraint(equalTo: targetEndLabel.bottomAnchor, constant: 3),
            targetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            targetUpperView.topAnchor.constraint(equalTo: targetEndLabel.bottomAnchor, constant: 3),
            targetUpperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetUpperView.heightAnchor.constraint(equalToConstant: 28),
            targetUpperView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.07,
               height: collectionView.frame.height/2.07)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        progressView.setProgress(0.6, animated: true)
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCell, for: indexPath) as! ProfileCollectionViewCell
        let model = resultWorkout[indexPath.row]
        cell.cellConfigure(model: model)
        cell.backgroundColor = (indexPath.row % 4 == 0) || (indexPath.row % 4 == 3) ? .specialGreen : .specialYellow
        return cell
    }
}

