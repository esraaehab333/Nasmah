//
//  ForecastView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct ForecastView: View {

    @StateObject private var vm: ForecastViewModel

    init(
        forecast: ForecastDayEntity,
        dayIndex: Int,
        dayLabel: String
    ) {
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
            vm.backgroundColor
                .ignoresSafeArea()

            ForecastContentView(vm: vm)
        }
        .navigationTitle(vm.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(vm.backgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            vm.onAppear()
        }
    }
}
