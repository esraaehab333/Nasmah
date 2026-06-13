//
//  SearchView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm: SearchViewModel
    @Binding var selectedCity: String
 
    init(conditionCode: Int? = nil, selectedCity: Binding<String>) {
        _vm = StateObject(wrappedValue: SearchViewModel(conditionCode: conditionCode))
        _selectedCity = selectedCity
    }
 
    var body: some View {
        NavigationStack {
            ZStack {
                vm.backgroundColor.ignoresSafeArea()
 
                VStack(spacing: 0) {
                    SearchBar(text: $vm.query, accentColor: vm.accentColor)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 8)
 
                    Divider()
                        .background(vm.primaryTextColor.opacity(0.12))
 
                    ZStack {
                        if vm.isSearching {
                            loadingState
                        } else if let error = vm.errorMessage {
                            errorState(message: error)
                        } else if vm.showSavedLocations {
                            savedList
                        } else if vm.searchResults.isEmpty && vm.query.count >= 2 {
                            emptyResults
                        } else {
                            resultsList
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: vm.isSearching)
                    .animation(.easeInOut(duration: 0.2), value: vm.searchResults.count)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(vm.backgroundColor, for: .navigationBar)
            .onAppear { vm.loadSavedLocations() }
        }
    }
 
    private var loadingState: some View {
        VStack(spacing: 14) {
            ProgressView().tint(vm.accentColor).scaleEffect(1.2)
            Text("Searching…")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
 
    private var resultsList: some View {
        List(vm.searchResults, id: \.id) { result in
            Button { selectedCity = "\(result.lat),\(result.lon)" } label: {
                SearchResultRow(result: result, vm: vm)
            }
            .listRowBackground(vm.cardBackground)
            .listRowSeparatorTint(vm.primaryTextColor.opacity(0.1))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
 
    private var savedList: some View {
        Group {
            if vm.savedLocations.isEmpty {
                VStack(spacing: 16) {
                    ZStack {
                        Circle().fill(vm.primaryTextColor.opacity(0.07)).frame(width: 72, height: 72)
                        Image(systemName: "bookmark.slash.fill")
                            .font(.system(size: 28, weight: .light))
                            .foregroundStyle(vm.primaryTextColor.opacity(0.35))
                    }
                    Text("No saved locations")
                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundStyle(vm.primaryTextColor.opacity(0.7))
                    Text("Search for a city and tap + to save it.")
                        .font(.system(size: 13, design: .rounded))
                        .foregroundStyle(vm.secondaryTextColor.opacity(0.5))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 60)
            } else {
                List {
                    Section {
                        ForEach(vm.savedLocations, id: \.name) { location in
                            Button {
                                selectedCity = "\(location.latitude),\(location.longitude)"
                            } label: {
                                SavedLocationRow(location: location, vm: vm)
                            }
                            .listRowBackground(vm.cardBackground)
                            .listRowSeparatorTint(vm.primaryTextColor.opacity(0.1))
                        }
                        .onDelete { vm.deleteLocation(at: $0) }
                    } header: {
                        HStack {
                            Image(systemName: "star.fill")
                                .font(.system(size: 10))
                                .foregroundStyle(vm.accentColor)
                            Text("Saved Locations")
                                .font(.system(size: 12, weight: .semibold, design: .rounded))
                                .foregroundStyle(vm.secondaryTextColor)
                        }
                        .textCase(nil)
                        .padding(.bottom, 4)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }
 
    private var emptyResults: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().fill(vm.primaryTextColor.opacity(0.07)).frame(width: 72, height: 72)
                Image(systemName: "location.slash.fill")
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(vm.primaryTextColor.opacity(0.4))
            }
            Text("No results found")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor.opacity(0.8))
            Text("No cities matched \"\(vm.query)\".\nTry a different spelling.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 60)
    }
 
    private func errorState(message: String) -> some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().fill(vm.primaryTextColor.opacity(0.07)).frame(width: 72, height: 72)
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(vm.primaryTextColor.opacity(0.5))
            }
            Text("Search unavailable")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor)
            Text(message)
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 60)
    }
}
