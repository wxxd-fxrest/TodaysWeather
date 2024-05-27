//
//  SearchResultsTableViewCell.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/27/24.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    private let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let searchResultWord: UILabel = {
        let label = UILabel()
        label.text = "대한민국, 서울" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 16)
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
        cellView.addSubview(searchResultWord)

        cellView.translatesAutoresizingMaskIntoConstraints = false
        searchResultWord.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cellView.heightAnchor.constraint(equalToConstant: 20),

            searchResultWord.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            searchResultWord.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
        ])
    }
}
