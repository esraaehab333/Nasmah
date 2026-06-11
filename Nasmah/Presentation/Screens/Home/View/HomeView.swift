//
//  HomeView.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var navigateToForecast = false
    @State private var selectedDayIndex: Int = 0
    @State private var showSearch = false
    @State private var showFavorites = false

    init(city: String = "Cairo") {
        _vm = StateObject(wrappedValue: HomeViewModel(city: city))
    }

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let heroHeight = screenHeight * 0.70

            NavigationStack {
                ZStack(alignment: .top) {
                    vm.backgroundColor
                        .ignoresSafeArea()

                    if !vm.isLoading && vm.errorMessage == nil {
                        Image(vm.backgroundImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: heroHeight)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    }

                    if vm.isLoading {
                        LoadingView(tint: vm.primaryTextColor)
                    } else if let error = vm.errorMessage {
                        ErrorView(message: error, textColor: vm.primaryTextColor) {
                            Task { await vm.loadWeather() }
                        }
                    } else {
                        HomeContentView(
                            vm: vm,
                            heroHeight: heroHeight,
                            selectedDayIndex: $selectedDayIndex,
                            navigateToForecast: $navigateToForecast
                        )
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HomeToolbarButtons(
                            primaryColor: vm.primaryTextColor,
                            onFavorites: { showFavorites = true },
                            onSearch: { showSearch = true }
                        )
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
                .task {
                    locationManager.requestLocation()
                    await vm.loadWeather()
                    vm.startAutoRefresh()
                }
                .onDisappear {
                    vm.stopAutoRefresh()
                }
                .onChange(of: locationManager.cityName) { newCity in
                    guard let newCity else { return }
                    vm.updateCity(newCity)
                    Task { await vm.loadWeather() }
                }
                .navigationDestination(isPresented: $navigateToForecast) {
                    if let day = vm.weather?.forecast[selectedDayIndex] {
                        ForecastView(
                            forecast: day,
                            dayIndex: selectedDayIndex,
                            dayLabel: vm.dayLabel(index: selectedDayIndex)
                        )
                    }
                }
                .sheet(isPresented: $showSearch) {
                    SearchSheetView { city in
                        showSearch = false
                        vm.updateCity(city)
                        Task { await vm.loadWeather() }
                    }
                }
                .sheet(isPresented: $showFavorites) {
                    FavoritesSheetView { city in
                        showFavorites = false
                        vm.updateCity(city)
                        Task { await vm.loadWeather() }
                    }
                }
            }
        }
    }
}
