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
                    .font(.system(size: 15, weight: isNow ? .bold : .medium, design: .rounded))
                    .foregroundStyle(.white)

                if isNow {
                    Text("LIVE")
                        .font(.system(size: 10, weight: .black))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color(hex: "#4CAF50")))
                }
            }
            .frame(width: 110, alignment: .leading)

            Spacer()

            AsyncImage(url: iconURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud.fill").foregroundStyle(.white.opacity(0.6))
            }
            .frame(width: 34, height: 34)

            Spacer()

            Text(conditionText)
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.8))
                .frame(width: 95, alignment: .center)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Spacer()

            Text("\(tempInt)°")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(width: 50, alignment: .trailing)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(isNow ? .white.opacity(0.1) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: isNow ? 16 : 0))
    }
}
