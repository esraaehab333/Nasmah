//
//  HomeViewModel+Helpers.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension HomeViewModel {

    var uvLabel: String {
        switch uvIndex {
        case 0...2: return "Low"
        case 3...5: return "Moderate"
        case 6...7: return "High"
        case 8...10: return "Very High"
        default: return "Extreme"
        }
    }

    var uvAdvice: String {
        switch uvIndex {
        case 0...2: return "No protection needed."
        case 3...5: return "Wear a sun hat."
        case 6...7: return "Use SPF 30+."
        case 8...10: return "Avoid sun 10–4."
        default: return "Take precautions."
        }
    }

    var humidityAdvice: String {
        switch humidityPct {
        case 0...30: return "Dry, stay hydrated."
        case 31...60: return "Comfortable."
        case 61...80: return "Slightly humid."
        default: return "Very humid."
        }
    }

    var visibilityLabel: String {
        switch visibility {
        case 0...2: return "Very poor visibility."
        case 3...5: return "Poor visibility."
        case 6...9: return "Moderate visibility."
        case 10...20: return "Good visibility."
        default: return "Excellent visibility."
        }
    }

    var windDescription: String {
        switch windKmh {
        case 0...1: return "Calm"
        case 2...5: return "Light air"
        case 6...11: return "Light breeze"
        case 12...19: return "Gentle breeze"
        case 20...28: return "Moderate breeze"
        case 29...38: return "Fresh breeze"
        default: return "Strong wind"
        }
    }

    var dewPointC: Int {
        let t = weather?.current.tempC ?? 0
        let rh = Double(humidityPct)
        return Int(t - ((100 - rh) / 5))
    }

    func dayLabel(index: Int) -> String {

        switch index {
        case 0:
            return "Today"
        case 1:
            return "Tomorrow"
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
