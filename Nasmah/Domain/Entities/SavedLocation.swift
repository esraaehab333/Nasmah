//
//  SavedLocation.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

struct SavedLocation {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    
    init(name: String, region: String = "", country: String = "", lat: Double = 0.0, lon: Double = 0.0) {
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
    }
}
