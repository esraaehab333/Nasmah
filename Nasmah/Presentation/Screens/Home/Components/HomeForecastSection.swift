//
//  HomeForecastSection.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//
/*
import SwiftUI

struct HomeForecastSection: View {

    let vm: HomeViewModel
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
                    }
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 16)
    }
}
*/
