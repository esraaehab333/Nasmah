//
//  ForecastSectionView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//


import SwiftUI

struct ForecastSectionView: View {
    @ObservedObject var vm: HomeViewModel
    @Binding var selectedDayIndex: Int
    @Binding var navigateToForecast: Bool

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { index in
                if let day = vm.weather?.forecast[index] {
                    Button {
                        selectedDayIndex = index
                        navigateToForecast = true
                    } label: {
                        ForecastRowView(
                            label: vm.dayLabel(index: index),
                            forecast: day,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor
                        )
                    }

                    if index < 2 {
                        Divider()
                            .background(vm.primaryTextColor.opacity(0.12))
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}
