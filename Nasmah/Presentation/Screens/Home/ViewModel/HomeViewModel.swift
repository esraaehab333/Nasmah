//
//  HomeViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var weather: WeatherEntity?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let fetchWeatherUseCase: FetchWeatherUseCaseProtocol

    var city: String

    var lastKnownTemp: Int?
    var refreshTimer: Timer?
    let autoRefreshInterval: TimeInterval = 300

    init(
        city: String = "Cairo",
        fetchWeatherUseCase: FetchWeatherUseCaseProtocol = DIContainer.shared.makeFetchWeatherUseCase()
    ) {
        self.city = city
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }

    func updateCity(_ newCity: String) {
        city = newCity
    }
}
