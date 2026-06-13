//
//  StatsGridView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

import SwiftUI
 
struct StatsGridView: View {
    @ObservedObject var vm: HomeViewModel
 
    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
 
    var body: some View {
        LazyVGrid(columns: columns, spacing: 14) {
 
            WeatherStatCard(
                icon: "sun.max.fill",
                title: "UV INDEX",
                value: vm.uvLabel,
                subtitle: "Index \(vm.uvIndex)",
                detail: vm.uvAdvice,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )
 
            WeatherStatCard(
                icon: "thermometer.medium",
                title: "FEELS LIKE",
                value: "\(vm.feelsLike)°",
                subtitle: "Actual: \(vm.tempInt)°",
                detail: feelsLikeDetail,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )
 
            WeatherStatCard(
                icon: "sunset.fill",
                title: "SUNSET",
                value: vm.sunsetTime,
                subtitle: "Sunrise: \(vm.sunriseTime)",
                detail: nil,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )
 
            WeatherStatCard(
                icon: "drop.fill",
                title: "HUMIDITY",
                value: "\(vm.humidityPct)%",
                subtitle: "Dew point: \(vm.dewPointC)°",
                detail: vm.humidityAdvice,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )
 
            WeatherStatCard(
                icon: "eye.fill",
                title: "VISIBILITY",
                value: "\(vm.visibility) km",
                subtitle: nil,
                detail: vm.visibilityLabel,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )
            WeatherStatCard(
                icon: "gauge.with.dots.needle.67percent",
                title: "PRESSURE",
                value: "\(vm.pressureMb) mb",
                subtitle: vm.pressureLabel,
                detail: vm.pressureAdvice,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )
        }
        .padding(.horizontal, 16)
    }
 
    private var feelsLikeDetail: String {
        if vm.feelsLike == vm.tempInt { return "Feels similar to actual weather." }
        return vm.feelsLike < vm.tempInt ? "Feels colder than actual." : "Feels warmer than actual."
    }
}
