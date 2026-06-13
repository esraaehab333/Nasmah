//
//  HomeViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var weather: WeatherEntity?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let fetchWeatherUseCase: FetchWeatherUseCaseProtocol
    var city: String
    var lastKnownTemp: Int?
    var refreshTimer: Timer?
    let autoRefreshInterval: TimeInterval = 300
 
    init(
        city: String = "Cairo",
        fetchWeatherUseCase: FetchWeatherUseCaseProtocol = DIContainer.shared.makeFetchWeatherUseCase()
    ) {
        self.city = city
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
 
    func updateCity(_ newCity: String) {
        city = newCity
    }
}
 
extension HomeViewModel {
    var theme: AppTheme {
        AppTheme(conditionCode: weather?.current.conditionCode)
    }
 
    var backgroundColor: Color    { theme.backgroundColor }
    var primaryTextColor: Color   { theme.primaryTextColor }
    var secondaryTextColor: Color { theme.secondaryTextColor }
    var backgroundImage: String   { theme.backgroundImage }
}
 
// MARK: - Weather loading
 
extension HomeViewModel {
    func loadWeather() async {
        isLoading = true
        errorMessage = nil
        do {
            weather = try await fetchWeatherUseCase.execute(query: city)
            lastKnownTemp = tempInt
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
 
// MARK: - Auto-refresh
 
extension HomeViewModel {
    func startAutoRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = Timer.scheduledTimer(
            withTimeInterval: autoRefreshInterval,
            repeats: true
        ) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                await self.refreshIfTempChanged()
            }
        }
    }
 
    func stopAutoRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
 
    private func refreshIfTempChanged() async {
        let previousTemp = lastKnownTemp
        await loadWeather()
        if let prev = previousTemp, tempInt != prev {
            print("🌡️ Temperature changed: \(prev) → \(tempInt)")
        }
    }
}
 
// MARK: - Computed properties
 
extension HomeViewModel {
    var todayForecast: ForecastDayEntity? { weather?.forecast.first }
    var cityName:      String  { weather?.location.name ?? "" }
    var tempInt:       Int     { Int(weather?.current.tempC ?? 0) }
    var condition:     String  { weather?.current.conditionText ?? "" }
    var feelsLike:     Int     { Int(weather?.current.feelsLikeC ?? 0) }
    var humidity:      Int     { weather?.current.humidity ?? 0 }
    var windKmh:       Int     { Int(weather?.current.windKph ?? 0) }
    var uvIndex:       Int     { Int(weather?.current.uvIndex ?? 0) }
    var visibility:    Int     { Int(weather?.current.visibilityKm ?? 0) }
    var pressureMb:    Int     { Int(weather?.current.pressureMb ?? 0) }   // ← new
    var sunriseTime:   String  { todayForecast?.sunrise ?? "--:--" }
    var sunsetTime:    String  { todayForecast?.sunset ?? "--:--" }
    var humidityPct:   Int     { weather?.current.humidity ?? 0 }
}
 
// MARK: - Helpers
 
extension HomeViewModel {
    var uvLabel: String {
        switch uvIndex {
        case 0...2:   return "Low"
        case 3...5:   return "Moderate"
        case 6...7:   return "High"
        case 8...10:  return "Very High"
        default:      return "Extreme"
        }
    }
 
    var uvAdvice: String {
        switch uvIndex {
        case 0...2:   return "No protection needed."
        case 3...5:   return "Wear a sun hat."
        case 6...7:   return "Use SPF 30+."
        case 8...10:  return "Avoid sun 10–4."
        default:      return "Take precautions."
        }
    }
 
    var humidityAdvice: String {
        switch humidityPct {
        case 0...30:  return "Dry, stay hydrated."
        case 31...60: return "Comfortable."
        case 61...80: return "Slightly humid."
        default:      return "Very humid."
        }
    }
 
    var visibilityLabel: String {
        switch visibility {
        case 0...2:   return "Very poor visibility."
        case 3...5:   return "Poor visibility."
        case 6...9:   return "Moderate visibility."
        case 10...20: return "Good visibility."
        default:      return "Excellent visibility."
        }
    }
 
    var windDescription: String {
        switch windKmh {
        case 0...1:   return "Calm"
        case 2...5:   return "Light air"
        case 6...11:  return "Light breeze"
        case 12...19: return "Gentle breeze"
        case 20...28: return "Moderate breeze"
        case 29...38: return "Fresh breeze"
        default:      return "Strong wind"
        }
    }
 
    // Pressure label — standard atmosphere is 1013 mb
    var pressureLabel: String {
        switch pressureMb {
        case 0...980:    return "Very Low"
        case 981...1000: return "Low"
        case 1001...1020: return "Normal"
        case 1021...1040: return "High"
        default:          return "Very High"
        }
    }
 
    var pressureAdvice: String {
        switch pressureMb {
        case 0...980:    return "Storm conditions possible."
        case 981...1000: return "Unsettled weather."
        case 1001...1020: return "Typical fair weather."
        case 1021...1040: return "Settled, clear skies."
        default:          return "Extremely high pressure."
        }
    }
 
    var dewPointC: Int {
        let t  = weather?.current.tempC ?? 0
        let rh = Double(humidityPct)
        return Int(t - ((100 - rh) / 5))
    }
 
    func dayLabel(index: Int) -> String {
        switch index {
        case 0: return "Today"
        case 1: return "Tomorrow"
        default:
            guard let day = weather?.forecast[index] else { return "" }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let date = formatter.date(from: day.date) else { return "" }
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        }
    }
}
