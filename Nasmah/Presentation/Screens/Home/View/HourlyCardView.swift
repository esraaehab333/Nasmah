//
//  HourlyCardView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//
//

import SwiftUI

struct HourlyCardView: View {
    @ObservedObject var vm: HomeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "clock")
                    .font(.system(size: 13, weight: .semibold))
                Text("HOURLY FORECAST")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .tracking(1)
            }
            .foregroundStyle(vm.secondaryTextColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 22) {
                    ForEach(vm.weather?.forecast.first?.hours.prefix(8) ?? [], id: \.time) { hour in
                        HourlyCellView(
                            hour: hour,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor
                        )
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .padding(18)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}
