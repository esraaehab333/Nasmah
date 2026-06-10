//
//  ForecastDayEntity.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

struct ForecastDayEntity {
    let date: String
    let maxTempC: Double
    let minTempC: Double
    let avgTempC: Double
    let avgHumidity: Int
    let avgVisibilityKm: Double
    let uvIndex: Double
    let sunrise: String
    let sunset: String
    let conditionText: String
    let conditionIcon: String
    let conditionCode: Int
    let hours: [HourEntity]
}
