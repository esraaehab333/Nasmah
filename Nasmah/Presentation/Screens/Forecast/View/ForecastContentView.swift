//
//  ForecastContentView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct ForecastContentView: View {
    @ObservedObject var vm: ForecastViewModel
 
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
 
                // Day summary card
                VStack(spacing: 6) {
                    AsyncImage(url: vm.iconURL(from: vm.forecast.conditionIcon)) { img in
                        img.resizable().scaledToFit()
                    } placeholder: {
                        Image(systemName: "cloud.sun.fill")
                            .foregroundStyle(vm.secondaryTextColor)
                    }
                    .frame(width: 64, height: 64)
 
                    Text(vm.forecast.conditionText)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(vm.primaryTextColor)
 
                    HStack(spacing: 16) {
                        Label("\(Int(vm.forecast.maxTempC))°", systemImage: "arrow.up")
                        Label("\(Int(vm.forecast.minTempC))°", systemImage: "arrow.down")
                    }
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(vm.secondaryTextColor)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(.white.opacity(0.15), lineWidth: 1)
                )
                .padding(.horizontal, 16)
 
                // Hourly list
                if !vm.hours.isEmpty {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Image(systemName: "clock")
                                .font(.system(size: 12, weight: .semibold))
                            Text("HOURLY BREAKDOWN")
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .tracking(1)
                        }
                        .foregroundStyle(vm.secondaryTextColor)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 10)
 
                        ForEach(Array(vm.hours.enumerated()), id: \.element.time) { index, hour in
                            ForecastHourRow(
                                hour: hour,
                                isCurrentHour: vm.isCurrentHour(hour),
                                formattedTime: vm.formattedTime(hour.time),
                                iconURL: vm.iconURL(from: hour.conditionIcon),
                                primaryColor: vm.primaryTextColor,
                                secondaryColor: vm.secondaryTextColor
                            )
 
                            if index < vm.hours.count - 1 {
                                Divider()
                                    .background(vm.primaryTextColor.opacity(0.08))
                                    .padding(.horizontal, 16)
                            }
                        }
                        .padding(.bottom, 8)
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
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
    }
}
