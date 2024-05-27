//
//  SearchViewController.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/26/24.
//

import UIKit

class BeforeSearchViewController: UIViewController {
    
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
        bar.isUserInteractionEnabled = false
        return bar
    }()
    
    private lazy var goSearchViewButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(goSearchViewTapped), for: .touchUpInside)
        return button
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
    
    private let searchOKImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "tickSquare")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    // MARK: - Tab Bar
    private let headerTabView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let tabBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.distribution = .fillEqually // 버튼을 균등하게 분배
        return stackView
    }()
    
    private let tobBottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TextColor")?.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var basicLocalButton: UIButton = {
        let button = UIButton()
        button.setTitle("Local", for: .normal)
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(localTabTapped), for: .touchUpInside)
        return button
    }()
    
    private let basicLocalViewBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TextColor")
        return view
    }()
    
    private lazy var markedLocalButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mark", for: .normal)
        button.setTitleColor(UIColor(named: "TextColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(markTabTapped), for: .touchUpInside)
        return button
    }()
    
    private let markedLocalViewBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "TextColor")
        return view
    }()
    
    // MARK: - Weather Table View
    private let weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "BackGroundColor")
        tableView.separatorStyle = .singleLine
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "WeatherCell")

        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(named: "BackGroundColor")

        designSearchViewUI()
        designTabBarUI()
        designWeatherTableUI()
        
        tabSwipe()
        // 현재 셀의 삭제, 북마크 스와이프 때문에 탭 스와이프가 안 됨, 수정해야 함
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
        searchStackView.addArrangedSubview(searchOKImage)
        backButton.addSubview(backImage)
        searchView.addSubview(goSearchViewButton)

        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        goSearchViewButton.translatesAutoresizingMaskIntoConstraints = false
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
            
            goSearchViewButton.topAnchor.constraint(equalTo: searchBar.topAnchor),
            goSearchViewButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            goSearchViewButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            goSearchViewButton.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            
            searchOKImage.centerYAnchor.constraint(equalTo: searchStackView.centerYAnchor),
            searchOKImage.widthAnchor.constraint(equalToConstant: 32),
            searchOKImage.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    // MARK: - designTabBarUI()
    private func designTabBarUI() {
        view.addSubview(headerTabView)
        headerTabView.addSubview(tabBarStackView)
        headerTabView.addSubview(tobBottomBorder)
        tabBarStackView.addArrangedSubview(basicLocalButton)
        tabBarStackView.addArrangedSubview(markedLocalButton)
        basicLocalButton.addSubview(basicLocalViewBar)
        markedLocalButton.addSubview(markedLocalViewBar)
    
        headerTabView.translatesAutoresizingMaskIntoConstraints = false
        tobBottomBorder.translatesAutoresizingMaskIntoConstraints = false
        tabBarStackView.translatesAutoresizingMaskIntoConstraints = false
        basicLocalButton.translatesAutoresizingMaskIntoConstraints = false
        markedLocalButton.translatesAutoresizingMaskIntoConstraints = false
        basicLocalViewBar.translatesAutoresizingMaskIntoConstraints = false
        markedLocalViewBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerTabView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            headerTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerTabView.heightAnchor.constraint(equalToConstant: 40),
            
            tobBottomBorder.leadingAnchor.constraint(equalTo: headerTabView.leadingAnchor),
            tobBottomBorder.trailingAnchor.constraint(equalTo: headerTabView.trailingAnchor),
            tobBottomBorder.topAnchor.constraint(equalTo: headerTabView.bottomAnchor, constant: -1),
            tobBottomBorder.heightAnchor.constraint(equalToConstant: 0.5),

            tabBarStackView.centerXAnchor.constraint(equalTo: headerTabView.centerXAnchor),
            tabBarStackView.centerYAnchor.constraint(equalTo: headerTabView.centerYAnchor),
            tabBarStackView.leadingAnchor.constraint(equalTo: headerTabView.leadingAnchor, constant: 4),
            tabBarStackView.trailingAnchor.constraint(equalTo: headerTabView.trailingAnchor, constant: -4),
            tabBarStackView.heightAnchor.constraint(equalToConstant: 40),

            basicLocalButton.centerYAnchor.constraint(equalTo: tabBarStackView.centerYAnchor),
            basicLocalButton.heightAnchor.constraint(equalToConstant: 40),
            
            basicLocalViewBar.topAnchor.constraint(equalTo: basicLocalButton.bottomAnchor, constant: -3),
            basicLocalViewBar.centerXAnchor.constraint(equalTo: basicLocalButton.centerXAnchor),
            basicLocalViewBar.widthAnchor.constraint(equalToConstant: 42),
            basicLocalViewBar.heightAnchor.constraint(equalToConstant: 2),

            markedLocalButton.centerYAnchor.constraint(equalTo: tabBarStackView.centerYAnchor),
            markedLocalButton.heightAnchor.constraint(equalToConstant: 40),
            
            markedLocalViewBar.topAnchor.constraint(equalTo: markedLocalButton.bottomAnchor, constant: -3),
            markedLocalViewBar.centerXAnchor.constraint(equalTo: markedLocalButton.centerXAnchor),
            markedLocalViewBar.widthAnchor.constraint(equalToConstant: 42),
            markedLocalViewBar.heightAnchor.constraint(equalToConstant: 2),
        ])
        
        basicLocalViewBar.isHidden = false
        markedLocalViewBar.isHidden = true
    }
    
    // MARK: - designWeatherTableUI()
    private func designWeatherTableUI() {
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
        view.addSubview(weatherTableView)
        
        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: headerTabView.bottomAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // MARK: - Action Tapped
    @objc func goMainPageTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func goSearchViewTapped() {
        print("click click")
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func localTabTapped() {
        print("local tab")
        toggleView(basicLocalViewBar, show: true)
        toggleView(markedLocalViewBar, show: false)
    }
    
    @objc func markTabTapped() {
        print("mark tab")
        toggleView(basicLocalViewBar, show: false)
        toggleView(markedLocalViewBar, show: true)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            print("Swiped left")
            markTabTapped()
        case .right:
            print("Swiped right")
            localTabTapped()
        default:
            break
        }
    }
    
    // MARK: - Swipe Gesture
    private func tabSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    private func toggleView(_ view: UIView, show: Bool) {
        if show {
            view.isHidden = false
            view.alpha = 0.0
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0.0
            }, completion: { _ in
                view.isHidden = true
            })
        }
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate methods
extension BeforeSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! SearchTableViewCell
        cell.localTitle.text = "Weather Data \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }

    // 왼쪽에서 오른쪽으로 스와이프 (Bookmark, Alarm)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 북마크 액션
        let bookmarkAction = UIContextualAction(style: .normal, title: "Bookmark") { (action, view, completionHandler) in
            print("Bookmark tapped")
            completionHandler(true)
        }
        bookmarkAction.backgroundColor = UIColor.systemBlue
        
        // 알람 액션
        let alarmAction = UIContextualAction(style: .normal, title: "Alarm") { (action, view, completionHandler) in
            print("Alarm tapped")
            completionHandler(true)
        }
        alarmAction.backgroundColor = UIColor.systemOrange
        
        let configuration = UISwipeActionsConfiguration(actions: [bookmarkAction, alarmAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    // 오른쪽에서 왼쪽으로 스와이프 (Delete)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 삭제 액션
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // 삭제 액션 수행
            print("Delete tapped")
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
