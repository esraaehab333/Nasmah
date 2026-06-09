//
//  SavedLocationsRepository.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

protocol SavedLocationsRepository {
    func saveLocation(_ location: SavedLocation)
    func fetchAllLocations() -> [SavedLocation]
    func deleteLocation(name: String)
}
