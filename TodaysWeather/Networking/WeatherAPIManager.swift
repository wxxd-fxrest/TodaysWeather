//
//  WeatherAPIManager.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/29/24.
//

import Foundation

class WeatherAPIManager {
    private let apiKey: String
    private let baseURL = "https://api.openweathermap.org/data/2.5/forecast"

    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getForecast(lat: Double, lon: Double, completion: @escaping (WeatherResponse?) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(nil)
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            print("URL 없음")
            completion(nil)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}

