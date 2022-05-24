//
//  SettingsViewController.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 23.05.22.
//
import UIKit
import RealmSwift

class SettingsViewController: UIViewController{
    
    private let editingProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "EDITING PROFILE"
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
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
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
    
    private let firstNameLabel = UILabel(text: "First name")
    
    let firstNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .specialBrown
        textfield.layer.cornerRadius = 10
        textfield.textColor = .specialGray
        textfield.font = .robotoBold20()
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.returnKeyType = .done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let secondNameLabel = UILabel(text: "Second name")
    
    private let secondNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .specialBrown
        textfield.layer.cornerRadius = 10
        textfield.textColor = .specialGray
        textfield.font = .robotoBold20()
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.returnKeyType = .done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let heightLabel = UILabel(text: "Height")
    
    private let heightTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .specialBrown
        textfield.layer.cornerRadius = 10
        textfield.textColor = .specialGray
        textfield.font = .robotoBold20()
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.returnKeyType = .done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let weightLabel = UILabel(text: "Weight")
    
    private let weightTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .specialBrown
        textfield.layer.cornerRadius = 10
        textfield.textColor = .specialGray
        textfield.font = .robotoBold20()
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.returnKeyType = .done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let targetLabel = UILabel(text: "Target (number of workouts)")
    
    private let targetTextField: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .specialBrown
        textfield.layer.cornerRadius = 10
        textfield.textColor = .specialGray
        textfield.font = .robotoBold20()
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.returnKeyType = .done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let localRealm = try! Realm()
    
    private var userModel = UserModel()
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(editingProfileLabel)
        view.addSubview(closeButton)
        view.addSubview(profileView)
        view.addSubview(userPhotoImageView)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(secondNameLabel)
        view.addSubview(secondNameTextField)
        view.addSubview(heightLabel)
        view.addSubview(heightTextField)
        view.addSubview(weightLabel)
        view.addSubview(weightTextField)
        view.addSubview(targetLabel)
        view.addSubview(targetTextField)
        view.addSubview((saveButton))
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
        setModel()
        saveModel()
        RealmManager.shared.updateUserModel(model: userModel)
    }
    
    private func setModel() {
        
        guard let userName = firstNameTextField.text else { return }
        userModel.firstName = userName
        
        guard let userSecondName = secondNameTextField.text else { return }
        userModel.secondName = userSecondName
        
        guard let userHeight = heightTextField.text else { return }
        userModel.height = Int(userHeight) ?? 0

        guard let userWeight = weightTextField.text else { return }
        userModel.weight = Int(userWeight) ?? 0
        
        guard let userTarget = targetTextField.text else { return }
        userModel.target = Int(userTarget) ?? 0
    }
    
    private func saveModel() {
        
        guard let text = firstNameTextField.text else { return }
        let count = text.filter{$0.isNumber || $0.isLetter}.count
        
        if count != 0 {
            RealmManager.shared.saveUserModel(model: userModel)
            userModel = UserModel()
        }
    }

    
}

//MARK: - SetConstraints

extension SettingsViewController {
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            editingProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            editingProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editingProfileLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: editingProfileLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: editingProfileLabel.bottomAnchor, constant: 20),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileView.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 40),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            firstNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 3),
            firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            secondNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 14),
            secondNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            secondNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 3),
            secondNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: secondNameTextField.bottomAnchor, constant: 14),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            heightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            heightTextField.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 3),
            heightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heightTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 14),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 3),
            weightTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            weightTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 14),
            targetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            targetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            targetTextField.topAnchor.constraint(equalTo: targetLabel.bottomAnchor, constant: 3),
            targetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            targetTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: targetTextField.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
}
