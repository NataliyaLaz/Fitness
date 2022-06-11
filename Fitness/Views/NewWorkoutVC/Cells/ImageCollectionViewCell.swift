//
//  ImageCollectionViewCell.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 11.06.22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "upperBody")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .specialYellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

        addSubview(selectImageView)
    }
    
    func cellConfigure(image: UIImage){
        print(image)
        selectImageView.image = image.withRenderingMode(.alwaysTemplate)
        selectImageView.tintColor = .white
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.white.cgColor
                backgroundColor = .specialYellow
            } else {
                layer.borderWidth = 0
                backgroundColor = .specialGreen
            }
        }
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            selectImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            selectImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            selectImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            selectImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}


