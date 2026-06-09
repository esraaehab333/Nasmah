//
//  HomeView.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).task {
            let container = DIContainer.shared

            // Test FetchWeatherUseCase
            let weatherUC = container.makeFetchWeatherUseCase()
            do {
                let weather = try await weatherUC.execute(query: "Cairo")
                print("✅ Entity OK — City: \(weather.location.name)")
                print("✅ Temp: \(weather.current.tempC)°C")
                print("✅ Forecast count: \(weather.forecast.count)")
                print("✅ Hours in day 1: \(weather.forecast[0].hours.count)")
            } catch {
                print("❌ UseCase FAILED: \(error)")
            }

            // Test SaveLocationUseCase
            let saveUC = container.makeSaveLocationUseCase()
            let fetchUC = container.makeFetchSavedLocationsUseCase()
            let deleteUC = container.makeDeleteLocationUseCase()

            try? saveUC.execute(SavedLocation(name:"London",
                                country:"UK", lat:51.5, lon:-0.1))
            let saved = fetchUC.execute()
            print("✅ Saved count: \(saved.count)")  // 1
            deleteUC.execute(name: "London")
            print("✅ After delete: \(fetchUC.execute().count)")  // 0
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
