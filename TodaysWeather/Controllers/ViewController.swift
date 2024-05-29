//
//  ViewController.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/26/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    private let weekCollectionViewWidth: CGFloat = 330
    private let weekCollectionViewHeight: CGFloat = 160
    
    // MARK: - Location View
    private let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "대한민국, 서울" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "now" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let searchImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "searchImage")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    private lazy var goSearchButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goBeforeSearchPageTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Weather View
    private let weatherView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let weatherImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "sunImage")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "23" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 86)
        return label
    }()
    
    private let weatherInfo: UILabel = {
        let label = UILabel()
        label.text = "Mostly Cloudy" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    // MARK: - Wind Speed Title & Stack View
    private let windSpeedTitle: UILabel = {
        let label = UILabel()
        label.text = "Wind"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let windSpeedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private let windSpeedImage: UIImageView = {
        let weatherImg = UIImageView()
        if let image = UIImage(named: "windImage")?.withRenderingMode(.alwaysTemplate) {
            weatherImg.image = image
        } // svg color change
        weatherImg.tintColor = UIColor(named: "TextColor")
        return weatherImg
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "4m/s" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Week Collection
    private let weekTitle: UILabel = {
        let label = UILabel()
        label.text = "Week Weather" // data
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
     private let weekCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumLineSpacing = 8
         
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.backgroundColor = .clear
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView
     }()
    
     private func setupCollectionView() {
         weekCollectionView.dataSource = self
         weekCollectionView.delegate = self
         weekCollectionView.register(MainViewCollectionViewCell.self, forCellWithReuseIdentifier: "WeekCell")
         weekCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
     }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackGroundColor")

        designHeaderUI()
        designWeatherUI()
        designWindSpeedUI()
        designWeekCollectionUI()
        
        guard let path = Bundle.main.path(forResource: "APIManager", ofType: "plist") else {
            fatalError("APIManager.plist not found")
        }

        guard let apiKeyDict = NSDictionary(contentsOfFile: path) as? [String: String],
              let apiKey = apiKeyDict["API_KEY"] else {
            fatalError("API key not found in APIManager.plist")
        }

        let viewModel = WeatherViewModel(apiKey: apiKey)
                
        viewModel.fetchWeather(lat: 37.5666791, lon: 126.9782914) { [weak self] in
            self?.weekCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.isNavigationBarHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    // MARK: - weekCollectionView Reload Data
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureView()
    }

    private func configureView() {
        weekCollectionView.reloadData()
    }

    // MARK: - designHeaderUI()
    private func designHeaderUI() {
        view.addSubview(titleView)
        titleView.addSubview(locationTitleLabel)
        titleView.addSubview(timeTitleLabel)
        titleView.addSubview(goSearchButton)
        goSearchButton.addSubview(searchImage)

        titleView.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        goSearchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 42),
            
            locationTitleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            locationTitleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            timeTitleLabel.topAnchor.constraint(equalTo: locationTitleLabel.bottomAnchor, constant: 0),
            timeTitleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            
            goSearchButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: -6),
            goSearchButton.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -16),
            goSearchButton.widthAnchor.constraint(equalToConstant: 36),
            goSearchButton.heightAnchor.constraint(equalToConstant: 36),
            
            searchImage.centerXAnchor.constraint(equalTo: goSearchButton.centerXAnchor),
            searchImage.centerYAnchor.constraint(equalTo: goSearchButton.centerYAnchor),
            searchImage.widthAnchor.constraint(equalToConstant: 30),
            searchImage.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    // MARK: - designWeatherUI()
    private func designWeatherUI() {
        view.addSubview(weatherView)
        weatherView.addSubview(weatherImage)
        weatherView.addSubview(tempLabel)
        weatherView.addSubview(weatherInfo)
        weatherView.addSubview(windSpeedTitle)
        
        weatherView.addSubview(windSpeedImage)
        weatherView.addSubview(windSpeedLabel)
        
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherInfo.translatesAutoresizingMaskIntoConstraints = false
        windSpeedTitle.translatesAutoresizingMaskIntoConstraints = false
        windSpeedImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 62),
            weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherView.widthAnchor.constraint(equalToConstant: 140),
            weatherView.heightAnchor.constraint(equalToConstant: 320),
            
            weatherImage.topAnchor.constraint(equalTo: weatherView.topAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 80),
            weatherImage.heightAnchor.constraint(equalToConstant: 80),
            
            tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 14),
            tempLabel.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            
            weatherInfo.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 14),
            weatherInfo.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
            
            windSpeedTitle.topAnchor.constraint(equalTo: weatherInfo.bottomAnchor, constant: 36),
            windSpeedTitle.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor),
        ])
    }
    
    // MARK: - designWindSpeedUI()
    private func designWindSpeedUI() {
        view.addSubview(windSpeedStackView)
        windSpeedStackView.addArrangedSubview(windSpeedImage)
        windSpeedStackView.addArrangedSubview(windSpeedLabel)
        
        windSpeedStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            windSpeedStackView.topAnchor.constraint(equalTo: windSpeedTitle.bottomAnchor, constant: 4),
            windSpeedStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            windSpeedImage.widthAnchor.constraint(equalToConstant: 22),
            windSpeedImage.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    // MARK: - designWeekCollectionUI()
    private func designWeekCollectionUI() {
        view.addSubview(weekCollectionView)
        setupCollectionView()
        view.addSubview(weekTitle)
        
        weekCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weekTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weekCollectionView.topAnchor.constraint(equalTo: windSpeedStackView.bottomAnchor, constant: 100),
            weekCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weekCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weekCollectionView.widthAnchor.constraint(equalToConstant: weekCollectionViewWidth),
            weekCollectionView.heightAnchor.constraint(equalToConstant: weekCollectionViewHeight),
            
            weekTitle.topAnchor.constraint(equalTo: weekCollectionView.topAnchor, constant: -40),
            weekTitle.leadingAnchor.constraint(equalTo: weekCollectionView.leadingAnchor)
        ])
    }
    
    @objc func goBeforeSearchPageTapped() {
        print("click")
        let beforeSearchVC = BeforeSearchViewController()
        navigationController?.pushViewController(beforeSearchVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegateFlowLayout methods
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekCell", for: indexPath) as! MainViewCollectionViewCell
        
        let daysOfWeek = ["월", "화", "수", "목", "금", "토", "일"]
        
        cell.weekLabel.text = daysOfWeek[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 160)
    }
}
