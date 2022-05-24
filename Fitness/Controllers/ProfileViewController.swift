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
        imageView.clipsToBounds = true
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
        label.text = "NATALIYA LAZOUSKAYA"
        label.textColor = .white
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height: 169"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight: 54"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var HeightAndWeightStackView = UIStackView()
    
    private lazy var editingButton: UIButton = {
        
        var configuration = UIButton.Configuration.borderless()
        configuration.baseForegroundColor = .specialGreen
        configuration.baseBackgroundColor = .clear
        configuration.buttonSize = .large
        configuration.title = "Editing"
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0)
        configuration.imagePadding = 5
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
        label.text = "TARGET: 20 workouts"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetStartLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetEndLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idProfileCell = "idProfileCell"
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userInfo: Results<UserModel>!
    
    private var resultWorkout = [ResultWorkout]()
  
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
       
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: idProfileCell)
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
        view.addSubview(targetStartLabel)
        view.addSubview(targetEndLabel)
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
    
    func viewConfigure(model: UserModel) {
        
        
        nameLabel.text = "\(model.firstName) \(model.secondName)"
        heightLabel.text = "Height: \(model.height)"
        weightLabel.text = "Weight: \(model.weight)"
        targetLabel.text = "TARGET: \(model.target) workouts"
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
            HeightAndWeightStackView.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 5),
            editingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            editingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            editingButton.heightAnchor.constraint(equalToConstant: 20)
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
            targetStartLabel.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 15),
            targetStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
        ])
        
        NSLayoutConstraint.activate([
            targetEndLabel.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 15),
            targetEndLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2.08,
               height: collectionView.frame.height/2.08)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCell, for: indexPath) as! ProfileCollectionViewCell
        cell.cellConfigure()
        return cell
    }
    
}

