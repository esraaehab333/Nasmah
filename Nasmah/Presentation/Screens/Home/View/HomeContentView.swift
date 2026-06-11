//
//  HomeContentView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//
/*
import SwiftUI

struct HomeContentView: View {

    @ObservedObject var vm: HomeViewModel
    let geometry: GeometryProxy

    @Binding var selectedDayIndex: Int
    @Binding var navigateToForecast: Bool
    @Binding var showSearch: Bool
    @Binding var showFavorites: Bool

    var body: some View {

        let heroHeight = geometry.size.height * 0.70

        ZStack(alignment: .top) {

            if vm.isLoading {

                LoadingView(tint: vm.primaryTextColor)

            } else if let error = vm.errorMessage {

                ErrorView(
                    message: error,
                    textColor: vm.primaryTextColor
                ) {
                    Task { await vm.loadWeather() }
                }

            } else {

                ScrollView(showsIndicators: false) {

                    VStack(spacing: 20) {

                        HomeHeroSection(
                            vm: vm,
                            heroHeight: heroHeight
                        )

                        HomeHourlySection(vm: vm)

                        HomeStatsGridView(vm: vm)

                        HomeForecastSection(
                            vm: vm,
                            selectedDayIndex: $selectedDayIndex,
                            navigateToForecast: $navigateToForecast
                        )
                    }
                    .padding(.bottom, 32)
                }
            }
        }
        .onChange(of: vm.city) { _ in }
    }
}
*/
