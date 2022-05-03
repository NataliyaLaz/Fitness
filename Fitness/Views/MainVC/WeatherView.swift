//
//  WeatherView.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 1.05.22.
//

import UIKit

class WeatherView: UIView {
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherStateLabel: UILabel = {
        let label = UILabel()
        label.font = .robotoMedium18()
        label.text = "Sunny"
        label.textColor = .specialGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherAdviceLabel: UILabel = {
        let label = UILabel()
        label.text = "The best time to have training outdoors. Finish your day with running"
        label.font = .robotoMedium14()
        label.textColor = .specialLightBrown
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
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
    
    func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        addShadowOnView()
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherImageView)
        addSubview(weatherStateLabel)
        addSubview(weatherAdviceLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10 ),
            weatherImageView.heightAnchor.constraint(equalToConstant: 60),
            weatherImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            weatherStateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherStateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherStateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75)
        ])
        
        NSLayoutConstraint.activate([
            weatherAdviceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            weatherAdviceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            weatherAdviceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -78),
            weatherAdviceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            
        ])
    }
}

