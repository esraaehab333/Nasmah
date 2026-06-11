//
//  HomeViewModel+ComputedProperties.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension HomeViewModel {

    var todayForecast: ForecastDayEntity? {
        weather?.forecast.first
    }

    var cityName: String { weather?.location.name ?? "" }
    var tempInt: Int { Int(weather?.current.tempC ?? 0) }
    var condition: String { weather?.current.conditionText ?? "" }
    var feelsLike: Int { Int(weather?.current.feelsLikeC ?? 0) }
    var humidity: Int { weather?.current.humidity ?? 0 }
    var windKmh: Int { Int(weather?.current.windKph ?? 0) }
    var uvIndex: Int { Int(weather?.current.uvIndex ?? 0) }
    var visibility: Int { Int(weather?.current.visibilityKm ?? 0) }

    var sunriseTime: String { todayForecast?.sunrise ?? "--:--" }
    var sunsetTime: String { todayForecast?.sunset ?? "--:--" }

    var humidityPct: Int { weather?.current.humidity ?? 0 }
}
