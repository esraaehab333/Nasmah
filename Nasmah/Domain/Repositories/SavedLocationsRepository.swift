//
//  SavedLocationsRepository.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

protocol SavedLocationsRepository {
    func saveLocation(name: String, region: String, country: String, latitude: Double, longitude: Double)
    func fetchAllLocations() -> [LocationEntity]
    func deleteLocation(name: String)
}
