//
//  ForecastHoursListView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct ForecastHoursListView: View {

    @ObservedObject var vm: ForecastViewModel

    var body: some View {

        ScrollView(showsIndicators: false) {

            LazyVStack(spacing: 0) {

                ForEach(
                    Array(vm.hours.enumerated()),
                    id: \.element.time
                ) { index, hour in

                    HourlyRowView(
                        time: vm.formattedTime(hour.time),
                        iconURL: vm.iconURL(from: hour.conditionIcon),
                        tempInt: Int(hour.tempC),
                        conditionText: hour.conditionText,
                        isNow: vm.isCurrentHour(hour)
                    )

                    if index < vm.hours.count - 1 {

                        Divider()
                            .background(
                                vm.primaryTextColor.opacity(0.15)
                            )
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
