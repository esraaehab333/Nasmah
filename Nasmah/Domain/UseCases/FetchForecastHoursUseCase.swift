//
//  FetchForecastHoursUseCase.swift
//  Nasmah
//
//  Created by Nemo on 09/06/2026.
//

import Foundation

protocol FetchForecastHoursUseCaseProtocol {
    func execute(query: String, dayIndex: Int) async throws -> [HourEntity]
}

class FetchForecastHoursUseCase: FetchForecastHoursUseCaseProtocol {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(query: String, dayIndex: Int = 0) async throws -> [HourEntity] {
        let weather = try await repository.getWeather(for: query)
        guard dayIndex < weather.forecast.count else { return [] }
        return weather.forecast[dayIndex].hours
    }
}
