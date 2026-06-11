//
//  HomeViewModel+Apperance.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

extension HomeViewModel {

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

    var primaryTextColor: Color { .white }
    var secondaryTextColor: Color { .white.opacity(0.75) }
}
