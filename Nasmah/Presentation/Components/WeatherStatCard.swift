//
//  WeatherStatCard.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct WeatherStatCard: View {
    let icon: String
    let title: String
    let value: String
    let subtitle: String?
    let detail: String?
    var primaryColor: Color = .white
    var secondaryColor: Color = .white.opacity(0.7)
    var cardBackground: Color = .white.opacity(0.12)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(secondaryColor)
                Text(title)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(secondaryColor)
                    .textCase(.uppercase)
            }

            Text(value)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(primaryColor)

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(secondaryColor)
            }
            if let detail {
                Text(detail)
                    .font(.system(size: 12))
                    .foregroundStyle(secondaryColor.opacity(0.8))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 130, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(cardBackground)
        )
    }
}
