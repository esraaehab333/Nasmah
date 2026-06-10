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
    let latitude: Double
    let longitude: Double
    
    init(name: String, region: String = "", country: String, lat: Double, lon: Double) {
        self.name = name
        self.region = region
        self.country = country
        self.latitude = lat
        self.longitude = lon
    }
}
