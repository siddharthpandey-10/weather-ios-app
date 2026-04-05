//
//  WeatherViewModel.swift
//  weather
//
//  Created by Siddharth Pandey on 30/03/26.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var city: String = "Delhi"
    @Published var temperature: String = "--"
    @Published var description: String = "--"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let service = WeatherService()
    
    func fetchWeather() {
        
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                let data = try await service.fetchWeather(for: city)
                
                temperature = "\(Int(data.main.temp))°C"
                description = data.weather.first?.description ?? "N/A"
                city = data.name
                
            } catch {
                errorMessage = "Failed to fetch weather"
            }
            
            isLoading = false
        }
    }
}
