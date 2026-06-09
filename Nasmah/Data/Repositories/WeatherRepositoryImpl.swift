//
//  WeatherRepositoryImpl.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

class WeatherRepositoryImpl: WeatherRepository {
    private let remoteDataSource: WeatherAPIService
    
    init(remoteDataSource: WeatherAPIService = WeatherAPIServiceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getWeather(for query: String) async throws -> WeatherResponseDTO {
        return try await remoteDataSource.fetchWeather(query: query)
    }
    
    func searchLocations(query: String) async throws -> [SearchResultDTO] {
        return try await remoteDataSource.searchLocations(query: query)
    }
}
