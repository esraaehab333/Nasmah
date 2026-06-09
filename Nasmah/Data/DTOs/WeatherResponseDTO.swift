//
//  WeatherResponseDTO.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import Foundation

struct WeatherResponseDTO: Codable {
    let location: LocationDTO
    let current: CurrentDTO
    let forecast: ForecastDTO
}

struct LocationDTO: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

struct CurrentDTO: Codable {
    let temp_c: Double
    let condition: ConditionDTO
}

struct ConditionDTO: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct ForecastDTO: Codable {
    let forecastday: [ForecastDayDTO]
}

struct ForecastDayDTO: Codable {
    let date: String
    let day: DayDTO
    let hour: [HourDTO]?
}

struct DayDTO: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let avgtemp_c: Double
    let condition: ConditionDTO
}

struct HourDTO: Codable {
    let time: String
    let temp_c: Double
    let condition: ConditionDTO
}
