//
//  HomeViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var weather: WeatherEntity?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var todayForecast: ForecastDayEntity? {
        weather?.forecast.first
    }
    private let fetchWeatherUseCase: FetchWeatherUseCaseProtocol
    var city: String

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
    func loadWeather() async {
        isLoading = true
        errorMessage = nil
        do {
            weather = try await fetchWeatherUseCase.execute(query: city)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    var cityName: String { weather?.location.name ?? "" }
    var tempInt: Int { Int(weather?.current.tempC ?? 0) }
    var condition: String { weather?.current.conditionText ?? "" }

    var feelsLike: Int  { Int(weather?.current.feelsLikeC ?? 0) }
    var humidity: Int { weather?.current.humidity ?? 0 }
    var windKmh: Int { Int(weather?.current.windKph ?? 0) }
    var uvIndex: Int { Int(weather?.current.uvIndex ?? 0) }
    var visibility: Int { Int(weather?.current.visibilityKm ?? 0) }

    var sunriseTime: String { todayForecast?.sunrise ?? "--:--" }
    var sunsetTime: String { todayForecast?.sunset  ?? "--:--" }
    var humidityPct: Int { weather?.current.humidity ?? 0 }

    enum DayPeriod {
        case morning, evening
    }

    var currentPeriod: DayPeriod {
        let hour = Calendar.current.component(.hour, from: Date())
        return (hour >= 5 && hour < 18) ? .morning : .evening
    }

    var backgroundImage: String {
        currentPeriod == .morning ? "morning" : "night"
    }

    var backgroundColor: Color {
        currentPeriod == .morning
            ? Color(hex: "#527E31")
            : Color(hex: "#0C2A2E")
    }

    var primaryTextColor: Color {
        currentPeriod == .morning ? .black : .white
    }

    var secondaryTextColor: Color {
        currentPeriod == .morning
            ? .black.opacity(0.6)
            : .white.opacity(0.7)
    }

    var cardBackground: Color {
        currentPeriod == .morning
            ? .black.opacity(0.06)
            : .white.opacity(0.12)
    }

    var heroGradient: LinearGradient {
        currentPeriod == .morning
            ? LinearGradient(
                colors: [.clear, Color(hex: "#527E31").opacity(0.9)],
                startPoint: .top,
                endPoint: .bottom
              )
            : LinearGradient(
                colors: [.clear, Color(hex: "#0C2A2E").opacity(0.85)],
                startPoint: .top,
                endPoint: .bottom
              )
    }

    var uvLabel: String {
        switch uvIndex {
        case 0...2:  return "Low"
        case 3...5:  return "Moderate"
        case 6...7:  return "High"
        case 8...10: return "Very High"
        default:     return "Extreme"
        }
    }

    // UV advice
    var uvAdvice: String {
        switch uvIndex {
        case 0...2:  return "No protection needed."
        case 3...5:  return "Wear a sun hat when going out."
        case 6...7:  return "Apply SPF 30+ sunscreen."
        case 8...10: return "Avoid sun between 10AM–4PM."
        default:     return "Take full precautions."
        }
    }

    // Humidity advice
    var humidityAdvice: String {
        switch humidityPct {
        case 0...30:  return "Dry weather, stay hydrated."
        case 31...60: return "Comfortable humidity level."
        case 61...80: return "Slightly humid outside."
        default:      return "Very humid, feels heavy."
        }
    }

    // Visibility label
    var visibilityLabel: String {
        switch visibility {
        case 0...2:   return "Very poor visibility."
        case 3...5:   return "Poor visibility."
        case 6...9:   return "Moderate visibility."
        case 10...20: return "Good visibility."
        default:      return "Excellent visibility."
        }
    }

    // Wind description
    var windDescription: String {
        switch windKmh {
        case 0...1:   return "Calm, smoke rises vertically."
        case 2...5:   return "Light air, barely felt."
        case 6...11:  return "Light breeze, leaves rustle."
        case 12...19: return "Gentle breeze, flags extended."
        case 20...28: return "Moderate breeze, flags flap."
        case 29...38: return "Fresh breeze, flags unfurled."
        default:      return "Strong wind, difficult to walk."
        }
    }

    // Dew point estimate from humidity + temp (Magnus formula)
    var dewPointC: Int {
        let t = weather?.current.tempC ?? 0
        let rh = Double(humidityPct)
        let dp = t - ((100 - rh) / 5)
        return Int(dp)
    }

    func dayLabel(index: Int) -> String {
        switch index {
        case 0: return "Today"
        case 1: return "Tomorrow"
        default:
            guard let day = weather?.forecast[safe: index] else { return "" }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let date = formatter.date(from: day.date) else { return "" }
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        }
    }

    private func iconURL(from path: String?) -> URL? {
        guard let path else { return nil }
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

