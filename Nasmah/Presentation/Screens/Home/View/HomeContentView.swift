//
//  HomeContentView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var vm: HomeViewModel
    let heroHeight: CGFloat
    @Binding var selectedDayIndex: Int
    @Binding var navigateToForecast: Bool

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                HeroSectionView(vm: vm, heroHeight: heroHeight)

                HourlyCardView(vm: vm)

                StatsGridView(vm: vm)

                ForecastSectionView(
                    vm: vm,
                    selectedDayIndex: $selectedDayIndex,
                    navigateToForecast: $navigateToForecast
                )
            }
            .padding(.bottom, 32)
        }
        .ignoresSafeArea(edges: .top)
    }
}
