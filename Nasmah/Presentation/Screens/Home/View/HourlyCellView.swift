//
//  HourlyCellView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//
/*
import SwiftUI

struct HourlyCellView: View {

    let hour: HourEntity
    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {

        VStack(spacing: 8) {

            Text(formattedHour)
                .foregroundStyle(secondaryColor)

            AsyncImage(url: iconURL)

            Text("\(Int(hour.tempC))°")
                .foregroundStyle(primaryColor)

            Text("\(hour.chanceOfRain)%")
                .foregroundStyle(secondaryColor)
        }
    }

    private var formattedHour: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = df.date(from: hour.time) else {
            return hour.time
        }

        df.dateFormat = "h a"
        return df.string(from: date)
    }

    private var iconURL: URL? {
        let fixed = hour.conditionIcon.hasPrefix("//")
        ? "https:" + hour.conditionIcon
        : hour.conditionIcon

        return URL(string: fixed)
    }
}
*/
