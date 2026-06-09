//
//  SaveLocationUseCase.swift
//  Nasmah
//
//  Created by Nemo on 09/06/2026.
//

import Foundation

protocol SaveLocationUseCaseProtocol {
    func execute(_ location: SavedLocation)
}

class SaveLocationUseCase: SaveLocationUseCaseProtocol {
    private let repository: SavedLocationsRepository

    init(repository: SavedLocationsRepository) {
        self.repository = repository
    }

    func execute(_ location: SavedLocation) {
        repository.saveLocation(location)
    }
}
