//
//  HomeStatsGridView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//
/*
import SwiftUI

struct HomeStatsGridView: View {

    let vm: HomeViewModel

    var body: some View {

        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 14) {

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
                icon: "wind",
                title: "WIND",
                value: "\(vm.windKmh) km/h",
                subtitle: nil,
                detail: vm.windDescription,
                primaryColor: vm.primaryTextColor,
                secondaryColor: vm.secondaryTextColor
            )

            WeatherStatCard(
                icon: "drop.fill",
                title: "HUMIDITY",
                value: "\(vm.humidityPct)%",
                subtitle: "Dew: \(vm.dewPointC)°",
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
        }
        .padding(.horizontal, 16)
    }
}
*/
