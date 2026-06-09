//
//  FetchSavedLocationsUseCase.swift
//  Nasmah
//
//  Created by Nemo on 09/06/2026.
//

import Foundation

protocol FetchSavedLocationsUseCaseProtocol {
    func execute() -> [SavedLocation]
}

class FetchSavedLocationsUseCase: FetchSavedLocationsUseCaseProtocol {
    private let repository: SavedLocationsRepository

    init(repository: SavedLocationsRepository) {
        self.repository = repository
    }

    func execute() -> [SavedLocation] {
        repository.fetchAllLocations()
    }
}
