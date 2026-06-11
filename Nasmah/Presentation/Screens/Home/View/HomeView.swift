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
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                heroSection
                                    .frame(height: heroHeight - 100)

                                hourlyCard
                                statsGrid
                                forecastSection
                            }
                            .padding(.bottom, 32)
                        }
                        .ignoresSafeArea(edges: .top)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 18) {
                            Button { showFavorites = true } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(Color(hex: "#A8D5A2"))
                                    .font(.system(size: 20, weight: .medium))
                            }
                            Button { showSearch = true } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(vm.primaryTextColor)
                                    .font(.system(size: 20, weight: .medium))
                            }
                        }
                    }
                }
                .background(Color.clear)
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

    // MARK: - Hero Section

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Spacer()
                .frame(height: 110)

            Text(vm.cityName)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor)
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)

            Text("\(vm.tempInt)°")
                .font(.system(size: 96, weight: .ultraLight, design: .rounded))
                .foregroundStyle(vm.primaryTextColor)
                .padding(.vertical, -10)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

            Text(vm.condition)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }

    // MARK: - Hourly Card

    private var hourlyCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "clock")
                    .font(.system(size: 13, weight: .semibold))
                Text("HOURLY FORECAST")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .tracking(1)
            }
            .foregroundStyle(vm.secondaryTextColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 22) {
                    ForEach(vm.weather?.forecast.first?.hours.prefix(8) ?? [], id: \.time) { hour in
                        HourlyCell(hour: hour, primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .padding(18)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }

    // MARK: - Stats Grid

    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 14) {
            WeatherStatCard(icon: "sun.max.fill", title: "UV INDEX", value: vm.uvLabel, subtitle: "Index \(vm.uvIndex)", detail: vm.uvAdvice, primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
            WeatherStatCard(icon: "thermometer.medium", title: "FEELS LIKE", value: "\(vm.feelsLike)°", subtitle: "Actual: \(vm.tempInt)°", detail: vm.feelsLike == vm.tempInt ? "Feels similar to actual weather." : vm.feelsLike < vm.tempInt ? "Feels colder than actual." : "Feels warmer than actual.", primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
            WeatherStatCard(icon: "wind", title: "WIND", value: "\(vm.windKmh) km/h", subtitle: nil, detail: vm.windDescription, primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
            WeatherStatCard(icon: "sunset.fill", title: "SUNSET", value: vm.sunsetTime, subtitle: "Sunrise: \(vm.sunriseTime)", detail: nil, primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
            WeatherStatCard(icon: "drop.fill", title: "HUMIDITY", value: "\(vm.humidityPct)%", subtitle: "Dew point: \(vm.dewPointC)°", detail: vm.humidityAdvice, primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
            WeatherStatCard(icon: "eye.fill", title: "VISIBILITY", value: "\(vm.visibility) km", subtitle: nil, detail: vm.visibilityLabel, primaryColor: vm.primaryTextColor, secondaryColor: vm.secondaryTextColor)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Forecast Section

    private var forecastSection: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { index in
                if let day = vm.weather?.forecast[index] {
                    Button {
                        selectedDayIndex = index
                        navigateToForecast = true
                    } label: {
                        ForecastRowView(
                            label: vm.dayLabel(index: index),
                            forecast: day,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor
                        )
                    }
                    if index < 2 {
                        Divider()
                            .background(vm.primaryTextColor.opacity(0.12))
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(.white.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 16)
    }
}

// MARK: - HourlyCell

private struct HourlyCell: View {
    let hour: HourEntity
    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(formattedHour)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundStyle(secondaryColor)

            AsyncImage(url: iconURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud.sun.fill").foregroundStyle(secondaryColor)
            }
            .frame(width: 32, height: 32)

            Text("\(Int(hour.tempC))°")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(primaryColor)

            HStack(spacing: 3) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(Color(hex: "#7EC8A4"))
                Text("\(hour.chanceOfRain)%")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(secondaryColor)
            }
        }
    }

    private var formattedHour: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = df.date(from: hour.time) else { return hour.time }
        df.dateFormat = "h a"
        return df.string(from: date).uppercased()
    }

    private var iconURL: URL? {
        let path = hour.conditionIcon
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
