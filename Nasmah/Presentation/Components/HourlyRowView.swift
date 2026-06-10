//
//  HourlyRowView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct HourlyRowView: View {
    let time: String
    let iconURL: URL?
    let tempInt: Int
    let conditionText: String
    let isNow: Bool

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 8) {
                Text(isNow ? "NOW" : time)
                    .font(.system(size: 15, weight: isNow ? .bold : .regular))
                    .foregroundStyle(.white)
                    .frame(width: 60, alignment: .leading)

                if isNow {
                    Text("NOW")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(
                            Capsule().fill(Color(hex: "#4CAF50"))
                        )
                }
            }
            .frame(width: 110, alignment: .leading)

            Spacer()
            AsyncImage(url: iconURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "cloud")
                    .foregroundStyle(.white.opacity(0.6))
            }
            .frame(width: 36, height: 36)

            Spacer()
            Text(conditionText)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.7))
                .frame(width: 90, alignment: .center)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Spacer()
            Text("\(tempInt)°")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 52, alignment: .trailing)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(
            isNow
                ? Color.white.opacity(0.08)
                : Color.clear
        )
    }
}
