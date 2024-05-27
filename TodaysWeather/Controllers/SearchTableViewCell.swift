//
//  SearchTableViewCell.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/27/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let localTitle: UILabel = {
        let label = UILabel()
        label.text = "대한민국, 서울" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "23" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 64)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        contentView.backgroundColor = UIColor(named: "BackGroundColor")
        contentView.addSubview(cellView)
        cellView.addSubview(localTitle)
        cellView.addSubview(weatherImage)
        cellView.addSubview(tempLabel)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        localTitle.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cellView.heightAnchor.constraint(equalToConstant: 120),

            localTitle.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 16),
            localTitle.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            
            weatherImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16),
            weatherImage.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            weatherImage.widthAnchor.constraint(equalToConstant: 60),
            weatherImage.heightAnchor.constraint(equalToConstant: 60),
            
            tempLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20),
            tempLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -4),
        ])
    }
}
