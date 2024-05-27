//
//  MainViewCollectionViewCell.swift
//  MVVMstudy
//
//  Created by 밀가루 on 5/26/24.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    
    let weatherView: UIImageView = {
        let weatherImg = UIImageView()
        return weatherImg
    }()

    let weekLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let weatherImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "sunImage")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    let weekWeatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Sun"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "23" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        updateWeatherViewImage()
    }
    
    private func setupCell() {
        contentView.addSubview(weatherView)
        
        let stackView = UIStackView(arrangedSubviews: [weekWeatherLabel, tempLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        weatherView.addSubview(stackView)
        weatherView.addSubview(weatherImage)
        weatherView.addSubview(weekLabel)
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherView.widthAnchor.constraint(equalToConstant: 120),
            weatherView.heightAnchor.constraint(equalToConstant: 160),
            
            weekLabel.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 12),
            weekLabel.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            
            weatherImage.topAnchor.constraint(equalTo: weekLabel.bottomAnchor, constant: 6),
            weatherImage.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 50),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 12),
            stackView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
        ])
        
        updateWeatherViewImage()
    }
    
    private func updateWeatherViewImage() {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            weatherView.image = UIImage(named: "glassViewDark")
        } else {
            weatherView.image = UIImage(named: "glassViewLight")
        }
    }
}
