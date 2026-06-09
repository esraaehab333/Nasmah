//
//  HomeView.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                let service = WeatherAPIServiceImpl()
                do {
                    let result = try await service.fetchWeather(query: "Cairo")
                    print("✅ API OK — City: \(result.location.name)")
                    print("✅ Temp: \(result.current.temp_c)°C")
                    print("✅ Forecast days: \(result.forecast.forecastday.count)")
                } catch {
                    print("❌ API FAILED: \(error)")
                }
                
                let manager = CoreDataManager.shared
                manager.saveLocation(name: "Test", region: "Test Region", country: "Test Country", latitude: 30.0, longitude: 31.0)
                let all = manager.fetchAllLocations()
                print("✅ CoreData count: \(all.count)")
                manager.deleteLocation(name: "Test")
                print("✅ After delete: \(manager.fetchAllLocations().count)")
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
