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

        if vm.isLoading {

            LoadingView(
                tint: vm.primaryTextColor
            )

        } else if let error = vm.errorMessage {

            ErrorView(
                message: error,
                textColor: vm.primaryTextColor
            ) {
                vm.onAppear()
            }

        } else if vm.hours.isEmpty {

            ForecastEmptyStateView(vm: vm)

        } else {

            ForecastHoursListView(vm: vm)
        }
    }
}
