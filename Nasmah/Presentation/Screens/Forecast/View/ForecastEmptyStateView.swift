//
//  ForecastEmptyStateView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct ForecastEmptyStateView: View {

    let vm: ForecastViewModel

    var body: some View {

        VStack(spacing: 14) {

            Image(systemName: "clock.badge.xmark")
                .font(.system(size: 48))
                .foregroundStyle(
                    vm.primaryTextColor.opacity(0.6)
                )

            Text("No hours available")
                .font(
                    .system(
                        size: 18,
                        weight: .semibold
                    )
                )
                .foregroundStyle(vm.primaryTextColor)

            Text(
                """
                Hourly data couldn't be loaded
                for this day.
                """
            )
            .font(.system(size: 14))
            .foregroundStyle(vm.secondaryTextColor)
            .multilineTextAlignment(.center)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}
