//
//  HomeViewModel+AutoRefresh.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import Foundation

extension HomeViewModel {

    func startAutoRefresh() {

        refreshTimer?.invalidate()

        refreshTimer = Timer.scheduledTimer(
            withTimeInterval: autoRefreshInterval,
            repeats: true
        ) { [weak self] _ in

            guard let self else { return }

            Task { @MainActor in
                await self.refreshIfTempChanged()
            }
        }
    }

    func stopAutoRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    private func refreshIfTempChanged() async {

        let previousTemp = lastKnownTemp

        await loadWeather()

        if let prev = previousTemp,
           tempInt != prev {

            print("🌡️ Temperature changed: \(prev) → \(tempInt)")
        }
    }
}
