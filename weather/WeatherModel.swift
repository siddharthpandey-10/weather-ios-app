//
//  WeatherModel.swift
//  weather
//
//  Created by Siddharth Pandey on 30/03/26.
//

import Foundation

// MARK: - Main Response
struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

// MARK: - Temperature Info
struct Main: Codable {
    let temp: Double
}

// MARK: - Weather Description
struct Weather: Codable {
    let description: String
    let icon: String
}
