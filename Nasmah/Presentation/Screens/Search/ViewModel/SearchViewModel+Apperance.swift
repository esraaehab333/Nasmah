//
//  SearchViewModel+Apperance.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

extension SearchViewModel {

    enum DayPeriod {
        case morning
        case evening
    }

    var currentPeriod: DayPeriod {
        let hour = Calendar.current.component(.hour, from: Date())
        return (hour >= 5 && hour < 18) ? .morning : .evening
    }

    var backgroundColor: Color {
        currentPeriod == .morning
        ? Color(hex: "#527E31")
        : Color(hex: "#0C2A2E")
    }

    var accentColor: Color {
        currentPeriod == .morning
        ? Color(hex: "#A8D5A2")
        : Color(hex: "#7EC8C8")
    }

    var cardBackground: Color {
        currentPeriod == .morning
        ? Color.white.opacity(0.10)
        : Color.white.opacity(0.07)
    }

    var primaryTextColor: Color { .white }

    var secondaryTextColor: Color { .white.opacity(0.75) }
}
