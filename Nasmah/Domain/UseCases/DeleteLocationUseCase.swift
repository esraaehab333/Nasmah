//
//  DeleteLocationUseCase.swift
//  Nasmah
//
//  Created by Nemo on 09/06/2026.
//

import Foundation

protocol DeleteLocationUseCaseProtocol {
    func execute(name: String)
}

class DeleteLocationUseCase: DeleteLocationUseCaseProtocol {
    private let repository: SavedLocationsRepository

    init(repository: SavedLocationsRepository) {
        self.repository = repository
    }

    func execute(name: String) {
        repository.deleteLocation(name: name)
    }
}
