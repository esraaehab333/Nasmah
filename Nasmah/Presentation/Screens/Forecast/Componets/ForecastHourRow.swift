//
//  ForecastHourRow.swift
//  Nasmah
//
//  Created by Nemo on 13/06/2026.
//

import SwiftUI

struct ForecastHourRow: View {
    let hour: HourEntity
    let isCurrentHour: Bool
    let formattedTime: String
    let iconURL: URL?
    let primaryColor: Color
    let secondaryColor: Color
 
    var body: some View {
        HStack(spacing: 12) {
            Text(formattedTime)
                .font(.system(size: 14, weight: isCurrentHour ? .bold : .medium, design: .rounded))
                .foregroundStyle(isCurrentHour ? primaryColor : secondaryColor)
                .frame(width: 56, alignment: .leading)
 
            AsyncImage(url: iconURL) { img in
                img.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud.sun.fill").foregroundStyle(secondaryColor)
            }
            .frame(width: 28, height: 28)
 
            Text(hour.conditionText)
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(secondaryColor)
                .lineLimit(1)
 
            Spacer()
 
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(Int(hour.tempC))°")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
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
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            isCurrentHour
                ? Color.white.opacity(0.08)
                : Color.clear
        )
    }
}
