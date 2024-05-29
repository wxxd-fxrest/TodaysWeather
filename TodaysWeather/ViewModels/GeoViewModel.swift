//
//  GeoViewModel.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/29/24.
//

import Foundation

class GeoViewModel {
    private let geoAPIManager: GeoAPIManager
    var cities: [City] = []
    
    init(apiKey: String) {
        self.geoAPIManager = GeoAPIManager(apiKey: apiKey)
    }
    
    func fetchWeather(searchText: String, completion: @escaping () -> Void) {
        geoAPIManager.searchLocation(searchText: searchText) { [weak self] (cities: [City]?) in
            if let cities = cities {
                self?.cities = cities
                print("Cities: \(cities)")
            } else {
                print("Failed city data")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
