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
    var primaryColor: Color
    var secondaryColor: Color
 
    var body: some View {
        HStack(spacing: 0) {
            Text(label)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(primaryColor)
                .frame(width: 95, alignment: .leading)
 
            Spacer()
 
            AsyncImage(url: iconURL) { img in
                img.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud.sun.fill").foregroundStyle(secondaryColor)
            }
            .frame(width: 32, height: 32)
 
            Spacer()
 
            HStack(spacing: 10) {
                Text("\(Int(forecast.minTempC))°")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(secondaryColor)
                    .frame(width: 32, alignment: .trailing)
 
                Capsule()
                    .fill(LinearGradient(
                        colors: [Color(hex: "#7EC8A4"), Color(hex: "#F4D03F")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: 60, height: 6)
 
                Text("\(Int(forecast.maxTempC))°")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(primaryColor)
                    .frame(width: 32, alignment: .leading)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .contentShape(Rectangle())
    }
 
    private var iconURL: URL? {
        let path = forecast.conditionIcon
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
