//
//  HourlyCell.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct HourlyCell: View {
    let hour: HourEntity
    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {
        VStack(spacing: 6) {
            Text(formattedHour)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(secondaryColor)

            AsyncImage(url: iconURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud").foregroundStyle(secondaryColor)
            }
            .frame(width: 28, height: 28)

            Text("\(Int(hour.tempC))°")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(primaryColor)

            HStack(spacing: 2) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(secondaryColor)
                Text("\(hour.chanceOfRain)%")
                    .font(.system(size: 11))
                    .foregroundStyle(secondaryColor)
            }
        }
    }

    private var formattedHour: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = df.date(from: hour.time) else { return hour.time }
        df.dateFormat = "h a"
        return df.string(from: date)
    }

    private var iconURL: URL? {
        let path = hour.conditionIcon
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
