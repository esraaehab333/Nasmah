//
//  ForecastRowView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct ForecastRowView: View {
    let label: String
    let forecast: ForecastDayEntity
    var primaryColor: Color = .white
    var secondaryColor: Color = .white.opacity(0.6)

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(primaryColor)
                .frame(width: 100, alignment: .leading)

            Spacer()

            AsyncImage(url: iconURL) { img in
                img.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud").foregroundStyle(secondaryColor)
            }
            .frame(width: 28, height: 28)

            Spacer()

            Text("\(Int(forecast.minTempC))°")
                .font(.system(size: 15))
                .foregroundStyle(secondaryColor)
                .frame(width: 36, alignment: .trailing)

            Capsule()
                .fill(LinearGradient(
                    colors: [Color(hex: "#7EC8A4"), Color(hex: "#F4D03F")],
                    startPoint: .leading, endPoint: .trailing
                ))
                .frame(width: 60, height: 5)
                .padding(.horizontal, 8)

            Text("\(Int(forecast.maxTempC))°")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(primaryColor)
                .frame(width: 36, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    private var iconURL: URL? {
        let path = forecast.conditionIcon
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
