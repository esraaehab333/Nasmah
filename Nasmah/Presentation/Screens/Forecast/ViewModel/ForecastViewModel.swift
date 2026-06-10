//
//  ForecastViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation

@MainActor
class ForecastViewModel: ObservableObject {
    @Published var hours: [HourEntity] = []
    @Published var navigationTitle: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let forecast: ForecastDayEntity
    private let dayIndex: Int
    private let dayLabel: String

    init(forecast: ForecastDayEntity, dayIndex: Int, dayLabel: String) {
        self.forecast = forecast
        self.dayIndex = dayIndex
        self.dayLabel = dayLabel
    }

    func onAppear() {
        navigationTitle = resolvedTitle()
        hours = filteredHours()
    }

    private func resolvedTitle() -> String {
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
    
    private func filteredHours() -> [HourEntity] {
        guard dayIndex == 0 else {
            return forecast.hours
        }
        let now = Date()
        let cal = Calendar.current
        let currentHour = cal.component(.hour, from: now)
        return forecast.hours.filter { hour in
            let hourInt = extractHour(from: hour.time)
            return hourInt >= currentHour
        }
    }

    private func extractHour(from timeString: String) -> Int {
        let components = timeString.split(separator: " ")
        guard components.count == 2 else { return 0 }
        let timePart = components[1]
        let hourPart = timePart.split(separator: ":").first ?? "0"
        return Int(hourPart) ?? 0
    }
    
    func isCurrentHour(_ hour: HourEntity) -> Bool {
        guard dayIndex == 0 else { return false }
        let cal = Calendar.current
        let currentHour = cal.component(.hour, from: Date())
        return extractHour(from: hour.time) == currentHour
    }

    func formattedTime(_ timeString: String) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = df.date(from: timeString) else { return timeString }
        df.dateFormat = "h a" 
        return df.string(from: date)
    }

    func iconURL(from path: String) -> URL? {
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
