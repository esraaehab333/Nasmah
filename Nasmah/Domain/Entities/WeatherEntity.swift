//
//  WeatherEntity.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

struct WeatherEntity {
    let location: Location
    let current: Current
    let forecast: [ForecastDayEntity]
    
    struct Location {
        let name: String
        let region: String
        let country: String
        let lat: Double
        let lon: Double
    }
    
    struct Current {
        let tempC: Double
        let conditionText: String
        let conditionIcon: String
        let conditionCode: Int
    }
}
