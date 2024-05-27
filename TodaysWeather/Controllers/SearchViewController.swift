//
//  SearchViewController.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/27/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Search View
    private let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .clear
        bar.searchBarStyle = .minimal
        bar.layer.cornerRadius = 10
        bar.placeholder = "왼쪽 버튼을 어떻게 누를까?"
        bar.setImage(UIImage(named: "search_back"), for: .search, state: .normal)
        bar.setImage(UIImage(named: "search_cancel"), for: .clear, state: .normal)
              
        return bar
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(goMainPageTapped), for: .touchUpInside)
        return button
    }()
    
    private let backImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "leftArrow")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    private lazy var searchOKButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let searchOKImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "tickSquare")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    private let recentSearchesLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Search Word Table View
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "BackGroundColor")
        tableView.separatorStyle = .singleLine
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: "SearchResultsCell")

        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackGroundColor")

        designSearchViewUI()
        designSearchResultTableViewUI()
    }
    
    // MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }
    
    // MARK: - designSearchViewUI()
    private func designSearchViewUI() {
        view.addSubview(searchView)
        searchView.addSubview(searchStackView)
        searchStackView.addArrangedSubview(backButton)
        searchStackView.addArrangedSubview(searchBar)
        searchStackView.addArrangedSubview(searchOKButton)
        backButton.addSubview(backImage)
        searchOKButton.addSubview(searchOKImage)

        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchOKButton.translatesAutoresizingMaskIntoConstraints = false
        backImage.translatesAutoresizingMaskIntoConstraints = false
        searchOKImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 62),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 60),
            
            searchStackView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchStackView.centerXAnchor.constraint(equalTo: searchView.centerXAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 10),
            searchStackView.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -10),
            searchStackView.heightAnchor.constraint(equalToConstant: 48),
            
            backButton.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            backImage.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            backImage.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backImage.widthAnchor.constraint(equalToConstant: 30),
            backImage.heightAnchor.constraint(equalToConstant: 30),
            
            searchBar.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 100),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            searchOKButton.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor),
            searchOKButton.widthAnchor.constraint(equalToConstant: 40),
            searchOKButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchOKImage.centerXAnchor.constraint(equalTo: searchOKButton.centerXAnchor),
            searchOKImage.centerYAnchor.constraint(equalTo: searchOKButton.centerYAnchor),
            searchOKImage.widthAnchor.constraint(equalToConstant: 32),
            searchOKImage.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    private func designSearchResultTableViewUI() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        view.addSubview(recentSearchesLabel)
        view.addSubview(searchTableView)

        recentSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentSearchesLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 6),
            recentSearchesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            searchTableView.topAnchor.constraint(equalTo: recentSearchesLabel.bottomAnchor, constant: 6),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
   
    // MARK: - Action Tapped
    @objc func goMainPageTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate methods
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath) as! SearchResultsTableViewCell
        cell.searchResultWord.text = "Weather Data \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
}
