//
//  HomeHourlySection.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//
/*
import SwiftUI

struct HomeHourlySection: View {

    let vm: HomeViewModel

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Image(systemName: "clock")
                Text("HOURLY FORECAST")
            }
            .foregroundStyle(vm.secondaryTextColor)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 22) {

                    ForEach(
                        vm.weather?.forecast.first?.hours.prefix(8) ?? [],
                        id: \.time
                    ) { hour in

                        HourlyCellView(
                            hour: hour,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor
                        )
                    }
                }
            }
        }
        .padding(18)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 16)
    }
}
*/
