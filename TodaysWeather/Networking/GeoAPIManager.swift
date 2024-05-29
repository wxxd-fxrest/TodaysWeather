//
//  GeoAPIManager.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/29/24.
//

import Foundation

class GeoAPIManager {
    private let baseURL = "https://api.openweathermap.org/geo/1.0/direct"
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func searchLocation(searchText: String, completion: @escaping ([City]?) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(nil)
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "limit", value: "5"),
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
                let cities = try JSONDecoder().decode([City].self, from: data)
                completion(cities)
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
