//
//  ForecastViewModel+Helpers.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension ForecastViewModel {

    func isCurrentHour(_ hour: HourEntity) -> Bool {
        guard dayIndex == 0 else {
            return false
        }

        let currentHour = Calendar.current.component(
            .hour,
            from: Date()
        )

        return extractHour(from: hour.time) == currentHour
    }

    func formattedTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = formatter.date(from: timeString) else {
            return timeString
        }

        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }

    func iconURL(from path: String) -> URL? {
        let fixedPath = path.hasPrefix("//")
        ? "https:" + path
        : path

        return URL(string: fixedPath)
    }

    func resolvedTitle() -> String {
        switch dayIndex {
        case 0:
            return "Today"

        case 1:
            return "Tomorrow"

        default:
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            guard let date = formatter.date(from: forecast.date) else {
                return dayLabel
            }

            formatter.dateFormat = "EEEE, MMM d"
            return formatter.string(from: date)
        }
    }

    func filteredHours() -> [HourEntity] {
        guard dayIndex == 0 else {
            return forecast.hours
        }

        let currentHour = Calendar.current.component(
            .hour,
            from: Date()
        )

        return forecast.hours.filter {
            extractHour(from: $0.time) >= currentHour
        }
    }

    func extractHour(from timeString: String) -> Int {
        let components = timeString.split(separator: " ")

        guard components.count == 2 else {
            return 0
        }

        let timePart = components[1]
        let hourPart = timePart.split(separator: ":").first ?? "0"

        return Int(hourPart) ?? 0
    }
}
