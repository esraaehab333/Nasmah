//
//  WeatherRepository.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

protocol WeatherRepository {
    func getWeather(for query: String) async throws -> WeatherEntity
    func searchLocations(query: String) async throws -> [SearchResult]
}
