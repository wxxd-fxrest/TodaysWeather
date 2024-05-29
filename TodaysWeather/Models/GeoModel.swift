//
//  GeoModel.swift
//  TodaysWeather
//
//  Created by 밀가루 on 5/29/24.
//

import Foundation

struct City: Codable {
    let name: String
    let localNames: [String: String]
    let latitude: Double
    let longitude: Double
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case latitude = "lat"
        case longitude = "lon"
        case country
    }
}
