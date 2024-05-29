//
//  WeatherViewModel.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/29/24.
//

import Foundation

class WeatherViewModel {
    private let weatherAPIManager: WeatherAPIManager
    var forecasts: [WeatherForecast] = []

    init(apiKey: String) {
        self.weatherAPIManager = WeatherAPIManager(apiKey: apiKey)
    }

    func fetchWeather(lat: Double, lon: Double, completion: @escaping () -> Void) {
        weatherAPIManager.getForecast(lat: lat, lon: lon) { [weak self] weatherResponse in
            if let weatherResponse = weatherResponse {
                self?.forecasts = weatherResponse.list
                print("weatherAPIManager: \(weatherResponse)")
            } else {
                print("weatherAPIManager 없음")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
