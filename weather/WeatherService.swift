//
//  WeatherService.swift
//  weather
//
//  Created by Siddharth Pandey on 30/03/26.
//



import Foundation

class WeatherService {
    
    private let apiKey = "fb6e9a52a896fb1fb85ce43883f8a07c"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decoded
    }
}


