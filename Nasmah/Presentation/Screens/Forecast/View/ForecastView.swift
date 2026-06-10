//
//  ForecastView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct ForecastView: View {
    @StateObject private var vm: ForecastViewModel
    init(forecast: ForecastDayEntity, dayIndex: Int, dayLabel: String) {
        _vm = StateObject(
            wrappedValue: ForecastViewModel(
                forecast: forecast,
                dayIndex: dayIndex,
                dayLabel: dayLabel
            )
        )
    }
    var body: some View {
        ZStack {
            Color(hex: "#2d5a27").ignoresSafeArea()
            if vm.hours.isEmpty {
                emptyState
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(vm.hours.enumerated()), id: \.element.time) { index, hour in
                            HourlyRowView(
                                time: vm.formattedTime(hour.time),
                                iconURL: vm.iconURL(from: hour.conditionIcon),
                                tempInt: Int(hour.tempC),
                                conditionText: hour.conditionText,
                                isNow: vm.isCurrentHour(hour)
                            )

                            if index < vm.hours.count - 1 {
                                Divider()
                                    .background(.white.opacity(0.15))
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white.opacity(0.1))
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationTitle(vm.navigationTitle)
        .navigationBarTitleDisplayMode(.large)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear { vm.onAppear() }
    }

    private var emptyState: some View {
        VStack(spacing: 14) {
            Image(systemName: "clock.badge.xmark")
                .font(.system(size: 48))
                .foregroundStyle(.white.opacity(0.6))
            Text("No hours available")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
            Text("Hourly data couldn't be loaded\nfor this day.")
                .font(.system(size: 14))
                .foregroundStyle(.white.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
