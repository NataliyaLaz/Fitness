//
//  ProfileCollectionViewCell.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 22.05.22.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    private let exerciseTitleLabel:UILabel = {
        let label = UILabel()
        label.text = "PUSH-UPS"
        label.font = .robotoMedium24()
        label.textColor  = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        imageView.image = UIImage(named: "upperBody")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let repsTotalLabel:UILabel = {
        let label = UILabel()
        label.text = "180"
        label.font = .robotoBold48()
        label.textColor  = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 20

        addSubview(exerciseTitleLabel)
        addSubview(exerciseImageView)
        addSubview(repsTotalLabel)
    }
    
    func cellConfigure(){
        if backgroundColor == .specialYellow || backgroundColor == nil {
            backgroundColor = .specialGreen
        } else {
            backgroundColor = .specialYellow
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            exerciseTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            exerciseTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            exerciseImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            exerciseImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 57),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 57)
        ])
        
        NSLayoutConstraint.activate([
            repsTotalLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 10),
            repsTotalLabel.centerYAnchor.constraint(equalTo: exerciseImageView.centerYAnchor)
        ])
    }
}

