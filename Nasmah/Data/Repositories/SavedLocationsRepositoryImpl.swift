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
    
    func saveLocation(name: String, region: String, country: String, latitude: Double, longitude: Double) {
        localDataSource.saveLocation(name: name, region: region, country: country, latitude: latitude, longitude: longitude)
    }
    
    func fetchAllLocations() -> [LocationEntity] {
        return localDataSource.fetchAllLocations()
    }
    
    func deleteLocation(name: String) {
        localDataSource.deleteLocation(name: name)
    }
}
