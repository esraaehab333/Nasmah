//
//  AppTheme.swift
//  Nasmah
//
//  Created by Nemo on 12/06/2026.
//

import SwiftUI

struct AppTheme {

    enum Period {
        case day, night
    }

    let period: Period

    init(conditionCode: Int? = nil) {
        let hour = Calendar.current.component(.hour, from: Date())
        let isDayHour = (hour >= 5 && hour < 18)
        if let code = conditionCode {
            switch code {
            case 1000:
                period = .day
            case 1003...1009:
                period = isDayHour ? .day : .night
            default:
                period = .night
            }
        } else {
            period = isDayHour ? .day : .night
        }
    }

    var isDay: Bool { period == .day }

    var backgroundColor: Color {
        isDay ? Color(hex: "#527E31") : Color(hex: "#0C2A2E")
    }

    var accentColor: Color {
        isDay ? Color(hex: "#A8D5A2") : Color(hex: "#7EC8C8")
    }

    var cardBackground: Color {
        Color.white.opacity(isDay ? 0.10 : 0.07)
    }

    var backgroundImage: String {
        isDay ? "morning" : "night"
    }

    var primaryTextColor: Color   { .white }
    var secondaryTextColor: Color { .white.opacity(0.75) }
}
