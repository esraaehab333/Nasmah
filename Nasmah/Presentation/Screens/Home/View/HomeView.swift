//
//  HomeView.swift
//  Nasmah
//
//  Created by Nemo on 05/06/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    @State private var navigateToForecast = false
    @State private var selectedDayIndex: Int = 0
    @State private var showSearch = false
    @State private var showFavorites = false

    init(city: String = "Cairo") {
        _vm = StateObject(wrappedValue: HomeViewModel(city: city))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                vm.backgroundColor.ignoresSafeArea()

                if vm.isLoading {
                    LoadingView(tint: vm.primaryTextColor)
                } else if let error = vm.errorMessage {
                    ErrorView(
                        message: error,
                        textColor: vm.primaryTextColor
                    ) {
                        Task {
                            await vm.loadWeather()
                        }
                    }
                }else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            heroSection
                            hourlyCard
                            statsGrid
                            forecastSection
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button { showFavorites = true } label: {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(Color(hex: "#A8D5A2"))
                                .font(.system(size: 18))
                        }
                        Button { showSearch = true } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(vm.primaryTextColor)
                                .font(.system(size: 18))
                        }
                    }
                }
            }
            .toolbarColorScheme(
                vm.currentPeriod == .morning ? .light : .dark,
                for: .navigationBar
            )
            .task { await vm.loadWeather() }
            .navigationDestination(isPresented: $navigateToForecast) {
                if let day = vm.weather?.forecast[safe: selectedDayIndex] {
                }
            }
        }
    }

    private var heroSection: some View {
        ZStack(alignment: .topLeading) {

            Image(vm.backgroundImage)
                .resizable()
                .scaledToFill()
                .frame(height: 500)
                .frame(maxWidth: .infinity)
                .clipped()
                .ignoresSafeArea(edges: .top)

            VStack(alignment: .leading, spacing: 4) {

                Spacer()
                    .frame(height: 60)

                Text(vm.cityName)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(vm.primaryTextColor)

                Text("\(vm.tempInt)°")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundStyle(vm.primaryTextColor)

                Text(vm.condition)
                    .font(.system(size: 17))
                    .foregroundStyle(vm.secondaryTextColor)
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, -97)
    }

    // MARK: - Forecast rows
    private var forecastSection: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { index in
                if let day = vm.weather?.forecast[safe: index] {
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
                            .background(vm.primaryTextColor.opacity(0.15))
                    }
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(vm.cardBackground)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    // MARK: - Hourly strip
    private var hourlyCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hourly forecast")
                .font(.system(size: 14))
                .foregroundStyle(vm.secondaryTextColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 24) {
                    ForEach(
                        vm.weather?.forecast.first?.hours.prefix(8) ?? [],
                        id: \.time
                    ) { hour in
                        HourlyCell(hour: hour, primaryColor: vm.primaryTextColor,
                                   secondaryColor: vm.secondaryTextColor)
                    }
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(vm.cardBackground)
        )
        .padding(.horizontal, 16)
        .padding(.top, 12)
    }

    // MARK: - Stats grid
    private var statsGrid: some View {
        LazyVGrid(
            columns: [GridItem(.flexible()), GridItem(.flexible())],
            spacing: 12
        ) {
            WeatherStatCard(icon: "sun.max",     title: "UV INDEX",
                            value: vm.uvLabel,   subtitle: "\(vm.uvIndex)",
                            detail: vm.uvAdvice,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor,
                            cardBackground: vm.cardBackground)

            WeatherStatCard(icon: "thermometer", title: "FEELS LIKE",
                            value: "\(vm.feelsLike)°",
                            subtitle: "Actual: \(vm.tempInt)°",
                            detail: vm.feelsLike == vm.tempInt
                                ? "Feels similar to actual."
                                : vm.feelsLike < vm.tempInt
                                    ? "Feels colder than actual."
                                    : "Feels warmer than actual.",
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor,
                            cardBackground: vm.cardBackground)

            WeatherStatCard(icon: "wind",        title: "WIND",
                            value: "\(vm.windKmh)", subtitle: "KM/H",
                            detail: vm.windDescription,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor,
                            cardBackground: vm.cardBackground)

            WeatherStatCard(icon: "sunset",      title: "SUNSET",
                            value: vm.sunsetTime,
                            subtitle: "Sunrise: \(vm.sunriseTime)",
                            detail: nil,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor,
                            cardBackground: vm.cardBackground)

            WeatherStatCard(icon: "drop",        title: "HUMIDITY",
                            value: "\(vm.humidityPct)%",
                            subtitle: "Dew point is \(vm.dewPointC)°",
                            detail: vm.humidityAdvice,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor,
                            cardBackground: vm.cardBackground)

            WeatherStatCard(icon: "eye",         title: "VISIBILITY",
                            value: "\(vm.visibility) km",
                            subtitle: nil,
                            detail: vm.visibilityLabel,
                            primaryColor: vm.primaryTextColor,
                            secondaryColor: vm.secondaryTextColor,
                            cardBackground: vm.cardBackground)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - HourlyCell
private struct HourlyCell: View {
    let hour: HourEntity
    let primaryColor: Color
    let secondaryColor: Color

    var body: some View {
        VStack(spacing: 6) {
            Text(formattedHour)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(secondaryColor)

            AsyncImage(url: iconURL) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image(systemName: "cloud").foregroundStyle(secondaryColor)
            }
            .frame(width: 28, height: 28)

            Text("\(Int(hour.tempC))°")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(primaryColor)

            HStack(spacing: 2) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(secondaryColor)
                Text("\(hour.chanceOfRain)%")
                    .font(.system(size: 11))
                    .foregroundStyle(secondaryColor)
            }
        }
    }

    private var formattedHour: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = df.date(from: hour.time) else { return hour.time }
        df.dateFormat = "h a"
        return df.string(from: date)
    }

    private var iconURL: URL? {
        let path = hour.conditionIcon
        let fixed = path.hasPrefix("//") ? "https:" + path : path
        return URL(string: fixed)
    }
}
