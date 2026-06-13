//
//  HourlyCellView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct HourlyCellView: View {
    let hour: HourEntity
    let primaryColor: Color
    let secondaryColor: Color
 
    var body: some View {
        VStack(spacing: 8) {
            Text(formattedHour)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(secondaryColor)
 
            AsyncImage(url: iconURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud.sun.fill").foregroundStyle(secondaryColor)
            }
            .frame(width: 32, height: 32)
 
            Text("\(Int(hour.tempC))°")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(primaryColor)
 
            HStack(spacing: 3) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(Color(hex: "#7EC8A4"))
                Text("\(hour.chanceOfRain)%")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(secondaryColor)
            }
        }
    }
 
    private var formattedHour: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = df.date(from: hour.time) else { return hour.time }
        df.dateFormat = "h a"
        return df.string(from: date).uppercased()
    }
 
    private var iconURL: URL? {
        let path = hour.conditionIcon
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
