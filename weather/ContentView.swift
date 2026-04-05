//
//  ContentView.swift
//  weather
//
//  Created by Siddharth Pandey on 30/03/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = WeatherViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // 🌈 Dynamic Background
                LinearGradient(
                    colors: backgroundGradient(),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        // 📍 City
                        Text(vm.city)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        // 🌡 Temperature
                        Text(vm.temperature)
                            .font(.system(size: 90, weight: .thin))
                            .foregroundColor(.white)
                        
                        // ☁️ Description
                        Text(vm.description.capitalized)
                            .foregroundColor(.white.opacity(0.8))
                        
                        // 🔍 Search Bar (Glass Style)
                        TextField("Search city", text: $vm.city)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .padding(.horizontal)
                        
                        // 🔘 Button
                        Button("Get Weather") {
                            vm.fetchWeather()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        // ⏳ Loading
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                        }
                        
                        // ❌ Error
                        if let error = vm.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                        }
                        
                        // 📦 Weather Card (Glass UI)
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Current Weather")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack {
                                Image(systemName: weatherIcon())
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(vm.temperature)
                                    Text(vm.description)
                                        .font(.caption)
                                }
                            }
                            .foregroundColor(.white)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        // 🔁 Navigation
                        NavigationLink("View Forecast") {
                            ForecastView(vm: vm)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.top, 40)
                }
            }
        }
    }
    
    // 🌤 Dynamic Icon
    func weatherIcon() -> String {
        let desc = vm.description.lowercased()
        
        if desc.contains("cloud") { return "cloud.fill" }
        if desc.contains("rain") { return "cloud.rain.fill" }
        if desc.contains("clear") { return "sun.max.fill" }
        if desc.contains("snow") { return "snow" }
        return "cloud.sun.fill"
    }
    
    // 🌈 Dynamic Background Colors
    func backgroundGradient() -> [Color] {
        let desc = vm.description.lowercased()
        
        if desc.contains("clear") {
            return [.blue, .orange]
        } else if desc.contains("cloud") {
            return [.gray, .blue]
        } else if desc.contains("rain") {
            return [.black, .blue]
        } else {
            return [.blue, .purple]
        }
    }
}

#Preview {
    ContentView()
}
