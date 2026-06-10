//
//  SearchView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel()
    @Binding var selectedCity: String

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#2d5a27").ignoresSafeArea()

                VStack(spacing: 0) {
                    // Search bar
                    SearchBar(text: $vm.query)
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 8)

                    if vm.isSearching {
                        ProgressView()
                            .tint(.white)
                            .padding(.top, 40)
                        Spacer()

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
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear { vm.loadSavedLocations() }
        }
    }

    // MARK: - Search Results List

    private var resultsList: some View {
        List(vm.searchResults, id: \.id) { result in
            Button {
                selectedCity = "\(result.lat),\(result.lon)"
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(result.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("\(result.region), \(result.country)")
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    Spacer()

                    Button {
                        vm.saveLocation(result)
                    } label: {
                        Image(systemName: vm.isSaved(result) ? "checkmark.circle.fill" : "plus.circle")
                            .font(.system(size: 22))
                            .foregroundStyle(
                                vm.isSaved(result)
                                    ? Color(hex: "#A8D5A2")
                                    : .white.opacity(0.7)
                            )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.white.opacity(0.08))
            .listRowSeparatorTint(.white.opacity(0.15))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    // MARK: - Saved Locations List

    private var savedList: some View {
        Group {
            if vm.savedLocations.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 40))
                        .foregroundStyle(.white.opacity(0.4))
                    Text("No saved locations")
                        .font(.system(size: 16))
                        .foregroundStyle(.white.opacity(0.5))
                    Text("Search for a city and tap + to save it.")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.35))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 60)
            } else {
                List {
                    Section {
                        ForEach(vm.savedLocations, id: \.name) { location in
                            Button {
                                selectedCity = "\(location.latitude),\(location.longitude)"
                            } label: {
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundStyle(Color(hex: "#A8D5A2"))
                                        .font(.system(size: 14))

                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(location.name)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(.white)
                                        Text("\(location.region), \(location.country)")
                                            .font(.system(size: 13))
                                            .foregroundStyle(.white.opacity(0.6))
                                    }

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.white.opacity(0.3))
                                }
                                .padding(.vertical, 4)
                            }
                            .listRowBackground(Color.white.opacity(0.08))
                            .listRowSeparatorTint(.white.opacity(0.15))
                        }
                        .onDelete { offsets in
                            vm.deleteLocation(at: offsets)
                        }
                    } header: {
                        Text("Saved Locations")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.5))
                            .textCase(.uppercase)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
    }

    // MARK: - Empty / Error states

    private var emptyResults: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.4))
            Text("No results for \"\(vm.query)\"")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.white.opacity(0.7))
            Text("Try a different city name.")
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.4))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 60)
    }

    private func errorState(message: String) -> some View {
        VStack(spacing: 12) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 40))
                .foregroundStyle(.white.opacity(0.5))
            Text("Search unavailable")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
            Text(message)
                .font(.system(size: 13))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 60)
    }
}
