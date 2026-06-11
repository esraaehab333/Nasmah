//
//  SearchViewModel+SavedLocations.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension SearchViewModel {

    func loadSavedLocations() {
        savedLocations = fetchSavedUseCase.execute()
    }

    func saveLocation(_ result: SearchResult) {

        guard !isSaved(result) else { return }

        saveUseCase.execute(
            SavedLocation(
                name: result.name,
                region: result.region,
                country: result.country,
                lat: result.lat,
                lon: result.lon
            )
        )

        loadSavedLocations()
    }

    func deleteLocation(at offsets: IndexSet) {

        offsets.forEach { index in
            guard index < savedLocations.count else { return }

            deleteUseCase.execute(
                name: savedLocations[index].name
            )
        }

        loadSavedLocations()
    }

    func isSaved(_ result: SearchResult) -> Bool {
        savedLocations.contains {
            $0.name == result.name
        }
    }

    var showSavedLocations: Bool {
        query.count < 2
    }
}
