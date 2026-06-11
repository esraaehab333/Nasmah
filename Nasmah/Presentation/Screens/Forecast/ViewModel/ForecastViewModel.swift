//
//  ForecastViewModel.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import Foundation
import SwiftUI

@MainActor
final class ForecastViewModel: ObservableObject {

    @Published var hours: [HourEntity] = []
    @Published var navigationTitle: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let forecast: ForecastDayEntity
    let dayIndex: Int
    let dayLabel: String

    init(
        forecast: ForecastDayEntity,
        dayIndex: Int,
        dayLabel: String
    ) {
        self.forecast = forecast
        self.dayIndex = dayIndex
        self.dayLabel = dayLabel
    }

    func onAppear() {
        navigationTitle = resolvedTitle()
        hours = filteredHours()
    }
}
