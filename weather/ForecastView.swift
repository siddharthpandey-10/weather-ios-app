import SwiftUI

struct ForecastView: View {
    
    @ObservedObject var vm: WeatherViewModel
    
    var body: some View {
        
        ZStack {
            
            // 🌈 Background
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 25) {
                    
                    // 📍 Title
                    Text("Forecast")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    // ⏰ HOURLY FORECAST
                    VStack(alignment: .leading) {
                        
                        Text("Hourly Forecast")
                            .foregroundColor(.white.opacity(0.8))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: 15) {
                                
                                ForEach(0..<12) { hour in
                                    
                                    VStack(spacing: 10) {
                                        
                                        Text("\(hour)h")
                                            .font(.caption)
                                        
                                        Image(systemName: "cloud.sun.fill")
                                        
                                        Text("\(20 + hour)°")
                                            .font(.headline)
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(15)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // 📅 5 DAY FORECAST
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("5-Day Forecast")
                            .foregroundColor(.white.opacity(0.8))
                        
                        ForEach(0..<5) { day in
                            
                            HStack {
                                
                                Text(dayName(day))
                                    .frame(width: 80, alignment: .leading)
                                
                                Image(systemName: "cloud.fill")
                                
                                Spacer()
                                
                                Text("\(18 + day)°")
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 30)
            }
        }
    }
    
    // 📅 Day helper
    func dayName(_ index: Int) -> String {
        let days = ["Today", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return days[index % days.count]
    }
}

#Preview {
    ForecastView(vm: WeatherViewModel())
}
