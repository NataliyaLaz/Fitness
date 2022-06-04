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
        imageView.image = UIImage(named: "addPhoto")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
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
    
    private let firstNameTextField = UITextField(text: "")
    
    private let secondNameLabel = UILabel(text: "Second name")
    
    private let secondNameTextField = UITextField(text: "")
    
    private let heightLabel = UILabel(text: "Height")
    
    private let heightTextField = UITextField(text: "")
    
    private let weightLabel = UILabel(text: "Weight")
    
    private let weightTextField = UITextField(text: "")
    
    private let targetLabel = UILabel(text: "No gap chellange (number of days)")
    
    private let targetTextField = UITextField(text: "")
    
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
    
    private var firstNameStackView = UIStackView()
    private var secondNameStackView = UIStackView()
    private var heightStackView = UIStackView()
    private var weightStackView = UIStackView()
    private var targetStackView = UIStackView()
    private var generalStackView = UIStackView()
    
    private let localRealm = try! Realm()
    private var userArray: Results<UserModel>!
    
    private var userModel = UserModel()
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userArray = localRealm.objects(UserModel.self)

        setupViews()
        setConstraints()
        addTaps()
        loadUserInfo()
    }
    
    deinit {
        print ("Settings ViewController was deinited")
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(editingProfileLabel)
        view.addSubview(closeButton)
        view.addSubview(profileView)
        view.addSubview(userPhotoImageView)
        firstNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField],
                                         axis: .vertical,
                                         spacing: 3)
        
        secondNameStackView = UIStackView(arrangedSubviews: [secondNameLabel, secondNameTextField],
                                         axis: .vertical,
                                         spacing: 3)
        
        heightStackView = UIStackView(arrangedSubviews: [heightLabel, heightTextField],
                                         axis: .vertical,
                                         spacing: 3)
        
        weightStackView = UIStackView(arrangedSubviews: [weightLabel, weightTextField],
                                         axis: .vertical,
                                         spacing: 3)
        
        targetStackView = UIStackView(arrangedSubviews: [targetLabel, targetTextField],
                                         axis: .vertical,
                                         spacing: 3)
        
        generalStackView = UIStackView(arrangedSubviews: [firstNameStackView,
                                                         secondNameStackView,
                                                         heightStackView,
                                                         weightStackView,
                                                         targetStackView],
                                       axis: .vertical,
                                       spacing: 20)
        view.addSubview(generalStackView)
        view.addSubview(saveButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        dismiss(animated: true, completion: nil)
        
        setModel()

        if userArray.count == 0 {
            RealmManager.shared.saveUserModel(model: userModel)
        } else {
            RealmManager.shared.updateUserModel(model: userModel)
        }
        userModel = UserModel()//обязательно нужно обнулять наш экземпляр, иначе ошибка будет при повторном нажатии кнопки save
    }
    
    private func setModel() {
        
        guard let userName = firstNameTextField.text,
              let userSecondName = secondNameTextField.text,
              let userHeight = heightTextField.text,
              let userWeight = weightTextField.text,
              let userTarget = targetTextField.text
        else { return }
        
        guard let intHeight = Int(userHeight),
              let intWeight = Int(userWeight),
              let intTarget = Int(userTarget)
        else { return }
        
        userModel.firstName = userName
        userModel.secondName = userSecondName
        userModel.height = intHeight
        userModel.weight = intWeight
        userModel.target = intTarget
        
        if userPhotoImageView.image == UIImage(named: "addPhoto") {
            userModel.image = nil
        } else {
            guard let userImage = userPhotoImageView.image?.pngData() else { return }
            userModel.image = userImage
        }
    }
    
    private func loadUserInfo() {
        if userArray.count != 0 {
            firstNameTextField.text = userArray[0].firstName
            secondNameTextField.text = userArray[0].secondName
            heightTextField.text = "\(userArray[0].height)"
            weightTextField.text = "\(userArray[0].weight)"
            targetTextField.text = "\(userArray[0].target)"
            guard let data = userArray[0].image else { return }
            guard let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
            userPhotoImageView.contentMode = .scaleAspectFit
        }
    }
    
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        userPhotoImageView.isUserInteractionEnabled = true
        userPhotoImageView.addGestureRecognizer(tapScreen)
    }
    
    @objc private func setUserPhoto() {
        alertGalleryOrPhoto { [weak self] source in//source передается из completion handler + weak self - слабая ссылка на метод, который мы применяем (addTaps)
            guard let self = self else { return }
            self.chooseImagePicker(source: source)
        }
    }
}
//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType){// we get this source from alert
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true//увеличивать, выбирать какую-то часть и тд
            imagePicker.sourceType = source// получили из алерта
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        userPhotoImageView.image = image
        userPhotoImageView.contentMode = .scaleAspectFit
        dismiss(animated: true)//убирается PickerController
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
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            secondNameTextField.heightAnchor.constraint(equalToConstant: 40),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            targetTextField.heightAnchor.constraint(equalToConstant: 40),
            
            generalStackView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 20),
            generalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            generalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: targetTextField.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
