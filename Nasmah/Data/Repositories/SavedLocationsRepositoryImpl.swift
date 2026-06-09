//
//  SavedLocationsRepositoryImpl.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

class SavedLocationsRepositoryImpl: SavedLocationsRepository {
    private let localDataSource: CoreDataManager

    init(localDataSource: CoreDataManager = .shared) {
        self.localDataSource = localDataSource
    }

    func saveLocation(_ location: SavedLocation) {
        localDataSource.saveLocation(
            name: location.name,
            region: location.region,
            country: location.country,
            latitude: location.latitude,
            longitude: location.longitude
        )
    }

    func fetchAllLocations() -> [SavedLocation] {
        localDataSource.fetchAllLocations().map {
            SavedLocation(
                name: $0.name ?? "",
                region: $0.region ?? "",
                country: $0.country ?? "",
                lat: $0.latitude,
                lon: $0.longitude
            )
        }
    }

    func deleteLocation(name: String) {
        localDataSource.deleteLocation(name: name)
    }
}
