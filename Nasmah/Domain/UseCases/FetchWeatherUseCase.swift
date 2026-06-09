//
//  File3.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

protocol FetchWeatherUseCaseProtocol {
    func execute(query: String) async throws -> WeatherEntity
}

class FetchWeatherUseCase: FetchWeatherUseCaseProtocol {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> WeatherEntity {
        try await repository.getWeather(for: query)
    }
}
