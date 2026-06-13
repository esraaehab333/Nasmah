//
//  ForecastViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import SwiftUI
 
@MainActor
final class ForecastViewModel: ObservableObject {
    @Published var hours: [HourEntity] = []
    @Published var navigationTitle: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
 
    let forecast: ForecastDayEntity
    let dayIndex: Int
    let dayLabel: String
 
    init(forecast: ForecastDayEntity, dayIndex: Int, dayLabel: String) {
        self.forecast = forecast
        self.dayIndex = dayIndex
        self.dayLabel = dayLabel
    }
 
    func onAppear() {
        navigationTitle = resolvedTitle()
        hours = filteredHours()
    }
 
    // MARK: - Theme
    // Use the forecast day's condition code so the theme matches the day being viewed.
 
    private var theme: AppTheme {
        AppTheme(conditionCode: forecast.conditionCode)
    }
 
    var backgroundColor: Color    { theme.backgroundColor }
    var primaryTextColor: Color   { theme.primaryTextColor }
    var secondaryTextColor: Color { theme.secondaryTextColor }
}
 
// MARK: - Helpers
 
extension ForecastViewModel {
    func isCurrentHour(_ hour: HourEntity) -> Bool {
        guard dayIndex == 0 else { return false }
        let currentHour = Calendar.current.component(.hour, from: Date())
        return extractHour(from: hour.time) == currentHour
    }
 
    func formattedTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else { return timeString }
        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }
 
    func iconURL(from path: String) -> URL? {
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
 
    func resolvedTitle() -> String {
        switch dayIndex {
        case 0: return "Today"
        case 1: return "Tomorrow"
        default:
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            guard let date = formatter.date(from: forecast.date) else { return dayLabel }
            formatter.dateFormat = "EEEE, MMM d"
            return formatter.string(from: date)
        }
    }
 
    func filteredHours() -> [HourEntity] {
        guard dayIndex == 0 else { return forecast.hours }
        let currentHour = Calendar.current.component(.hour, from: Date())
        return forecast.hours.filter { extractHour(from: $0.time) >= currentHour }
    }
 
    func extractHour(from timeString: String) -> Int {
        let parts = timeString.split(separator: " ")
        guard parts.count == 2 else { return 0 }
        return Int(parts[1].split(separator: ":").first ?? "0") ?? 0
    }
}
