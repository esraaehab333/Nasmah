//
//  SearchLocarionUseCase.swift
//  Nasmah
//
//  Created by Nemo on 09/06/2026.
//

import Foundation

protocol SearchLocationsUseCaseProtocol {
    func execute(query: String) async throws -> [SearchResult]
}

class SearchLocationsUseCase: SearchLocationsUseCaseProtocol {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [SearchResult] {
        try await repository.searchLocations(query: query)
    }
}
