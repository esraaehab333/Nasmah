//
//  HomeViewModel+Weather.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension HomeViewModel {

    func loadWeather() async {

        isLoading = true
        errorMessage = nil

        do {
            weather = try await fetchWeatherUseCase.execute(query: city)
            lastKnownTemp = tempInt
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
